//
//  FileDownloadManager.m
//  Tools
//
//  Created by 张书孟 on 2017/12/26.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "FileDownloadManager.h"
#import "NSString+Hash.h"

// 缓存主目录
#define CachesDirectory [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"FileCache"]

// 缓存副目录
#define CachesFileName(fileName) [CachesDirectory stringByAppendingPathComponent:fileName]

// 保存文件名
#define FileName(url) [NSString stringWithFormat:@"%@.%@", url.md5String, url.pathExtension]

// 文件的存放路径（caches）
#define FileFullpath(url,fileName) [CachesFileName(fileName) stringByAppendingPathComponent:FileName(url)]

// 文件的已下载长度
#define DownloadLength(url,fileName) [[[NSFileManager defaultManager] attributesOfItemAtPath:FileFullpath(url,fileName) error:nil][NSFileSize] integerValue]

// 存储文件总长度的文件路径（caches）
#define TotalLengthFullpath(fileName) [CachesFileName(fileName) stringByAppendingPathComponent:@"totalLength.plist"]

// 存储文件信息的文件路径
#define AttributeFullpath(fileName) [CachesFileName(fileName) stringByAppendingPathComponent:@"attribute.plist"]

// 默认文件夹名称
#define DefaultFileName @"Default"

@interface FileDownloadManager ()<NSCopying, NSURLSessionDelegate>

/** 保存所有任务(注：用下载地址md5后作为key) */
@property (nonatomic, strong) NSMutableDictionary *tasks;
/** 保存所有下载相关信息 */
@property (nonatomic, strong) NSMutableDictionary *sessionModels;
/** 自定义缓存路径名称 默认：Default */
@property (nonatomic, strong) NSString *fileName;

@end

@implementation FileDownloadManager

static FileDownloadManager *_downloadManager;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _downloadManager = [super allocWithZone:zone];
    });
    
    return _downloadManager;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone
{
    return _downloadManager;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _downloadManager = [[self alloc] init];
    });
    
    return _downloadManager;
}

#pragma mark - private
/**
 *  创建缓存目录文件
 */
- (void)createCacheDirectoryWithFileName:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:CachesFileName(fileName)]) {
        [fileManager createDirectoryAtPath:CachesFileName(fileName) withIntermediateDirectories:YES attributes:nil error:NULL];
    }
}

- (void)handle:(NSString *)url
{
    NSURLSessionDataTask *task = [self getTask:url];
    if (task.state == NSURLSessionTaskStateRunning) {
        [self pause:url];
    } else {
        [self start:url];
    }
}

/**
 *  根据url获得对应的下载任务
 */
- (NSURLSessionDataTask *)getTask:(NSString *)url
{
    return (NSURLSessionDataTask *)[self.tasks valueForKey:FileName(url)];
}

/**
 *  根据url获取对应的下载信息模型
 */
- (FileSessionModel *)getSessionModel:(NSUInteger)taskIdentifier
{
    return (FileSessionModel *)[self.sessionModels valueForKey:@(taskIdentifier).stringValue];
}

#pragma mark - public
/**
 *  开启任务下载资源
 */
- (void)downloadWithUrl:(NSString *)url fileName:(NSString *)fileName attribute:(NSDictionary *)attribute progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress))progressBlock state:(void(^)(DownloadState state))stateBlock
{
    if (!url) return;
    if (!fileName) {
        fileName = DefaultFileName;
    }
    self.fileName = fileName;
    if ([self isCompletion:url fileName:fileName]) {
        stateBlock(DownloadStateCompleted);
        NSLog(@"----该资源已下载完成");
        return;
    }
    
    // 暂停
    if ([self.tasks valueForKey:FileName(url)]) {
        [self handle:url];
        return;
    }
    
    // 创建缓存目录文件
    [self createCacheDirectoryWithFileName:fileName];
    //    NSURLRequestUseProtocolCachePolicy
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    // 创建流
    NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:FileFullpath(url,fileName) append:YES];
    
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    // 忽略本地缓存，代理服务器以及其他中介，直接请求源服务端
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    // 设置请求头
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-", DownloadLength(url,fileName)];
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    // 创建一个Data任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    NSUInteger taskIdentifier = arc4random() % ((arc4random() % 10000 + arc4random() % 10000));
    [task setValue:@(taskIdentifier) forKeyPath:@"taskIdentifier"];
    
    // 保存任务
    [self.tasks setValue:task forKey:FileName(url)];
    
    FileSessionModel *sessionModel = [[FileSessionModel alloc] init];
    sessionModel.url = url;
    sessionModel.progressBlock = progressBlock;
    sessionModel.stateBlock = stateBlock;
    sessionModel.stream = stream;
    sessionModel.attribute = attribute;
    [self.sessionModels setValue:sessionModel forKey:@(task.taskIdentifier).stringValue];
    
    [self start:url];
}


/**
 *  开始下载
 */
- (void)start:(NSString *)url
{
    NSURLSessionDataTask *task = [self getTask:url];
    [task resume];
    
    [self getSessionModel:task.taskIdentifier].stateBlock(DownloadStateStart);
}

/**
 *  暂停下载
 */
- (void)pause:(NSString *)url
{
    NSURLSessionDataTask *task = [self getTask:url];
    [task suspend];
    
    [self getSessionModel:task.taskIdentifier].stateBlock(DownloadStateSuspended);
}

/**
 *  判断该文件是否下载完成
 */
- (BOOL)isCompletion:(NSString *)url fileName:(NSString *)fileName
{
    if (!fileName) {
        fileName = DefaultFileName;
    }
    self.fileName = fileName;
    if ([self fileTotalLength:url fileName:fileName] && DownloadLength(url, fileName) == [self fileTotalLength:url fileName:fileName]) {
        return YES;
    }
    return NO;
}

/**
 *  判断该文件是否存在
 */
- (BOOL)isExistence:(NSString *)url fileName:(NSString *)fileName
{
    if (!fileName) {
        fileName = DefaultFileName;
    }
    self.fileName = fileName;
    
    NSArray *fileList = [[NSArray alloc] init];
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSError *error = nil;
    fileList = [fileManager contentsOfDirectoryAtPath:CachesFileName(fileName) error:&error];
    if ([fileList containsObject:FileName(url)]) {
        return YES;
    }
    return NO;
}

/**
 *  查询该资源的下载进度值
 */
- (CGFloat)progress:(NSString *)url fileName:(NSString *)fileName
{
    if (!fileName) {
        fileName = DefaultFileName;
    }
    self.fileName = fileName;
    
    return [self fileTotalLength:url fileName:fileName] == 0 ? 0.0 : 1.0 * DownloadLength(url,fileName) /  [self fileTotalLength:url fileName:fileName];
}

/**
 *  获取该资源总大小
 */
- (NSInteger)fileTotalLength:(NSString *)url fileName:(NSString *)fileName
{
    if (!fileName) {
        fileName = DefaultFileName;
    }
    self.fileName = fileName;
    
    return [[NSDictionary dictionaryWithContentsOfFile:TotalLengthFullpath(fileName)][FileName(url)] integerValue];
}

/**
 *  获取文件存放路径（Documents)
 */
- (NSString *)getFileRoute {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
/**
 *  获取下载文件的信息
 */
- (NSArray *)getAttribute:(NSString *)fileName {
    if (!fileName) {
        fileName = DefaultFileName;
    }
    self.fileName = fileName;
    
    NSMutableArray *attributArr = [NSMutableArray array];
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:AttributeFullpath(fileName)];
    
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSString *dic in dataDic) {
        NSDictionary *dict = [dataDic valueForKey:dic];
        [mArr addObject:dict];
    }
    for (NSInteger i = 0; i < mArr.count; i++) {
        [attributArr addObject:mArr[i][@"attribute"]];
    }
    return [attributArr copy];
}

/**
 *  删除该资源
 */
- (void)deleteFile:(NSString *)url fileName:(NSString *)fileName
{
    if (!fileName) {
        fileName = DefaultFileName;
    }
    self.fileName = fileName;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:FileFullpath(url,fileName)]) {
        
        // 删除沙盒中的资源
        [fileManager removeItemAtPath:FileFullpath(url,fileName) error:nil];
        // 删除任务
        [self.tasks removeObjectForKey:FileName(url)];
        [self.sessionModels removeObjectForKey:@([self getTask:url].taskIdentifier).stringValue];
        
        // 删除资源总长度
        if ([fileManager fileExistsAtPath:TotalLengthFullpath(fileName)]) {
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:TotalLengthFullpath(fileName)];
            [dict removeObjectForKey:FileName(url)];
            [dict writeToFile:TotalLengthFullpath(fileName) atomically:YES];
            
        }
        
        if ([fileManager fileExistsAtPath:AttributeFullpath(fileName)]) {
            NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:AttributeFullpath(fileName)];
            if (!dataDic) {
                return;
            }
            for (NSString *mdURL in dataDic) {
                if ([mdURL isEqualToString:FileName(url)]) {
                    [dataDic removeObjectForKey:mdURL];
                    NSLog(@"%@",dataDic);
                    break;
                }
            }
            [dataDic writeToFile:AttributeFullpath(fileName) atomically:YES];
        }
    }
}

/**
 *  清空所有下载资源
 */
- (void)deleteAllFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:CachesDirectory]) {
        // 删除沙盒中所有资源
        [fileManager removeItemAtPath:CachesDirectory error:nil];
        // 删除任务
        [[self.tasks allValues] makeObjectsPerformSelector:@selector(cancel)];
        [self.tasks removeAllObjects];
        
        for (FileSessionModel *sessionModel in [self.sessionModels allValues]) {
            [sessionModel.stream close];
        }
        [self.sessionModels removeAllObjects];
        
        // 删除资源总长度
        //        if ([fileManager fileExistsAtPath:TotalLengthFullpath(self.fileName)]) {
        //            [fileManager removeItemAtPath:HSTotalLengthFullpath(self.fileName) error:nil];
        //        }
        //
        //        if ([fileManager fileExistsAtPath:AttributeFullpath(self.fileName)]) {
        //            [fileManager removeItemAtPath:AttributeFullpath(self.fileName) error:nil];
        //        }
    }
}

#pragma mark - 代理
#pragma mark NSURLSessionDataDelegate
/**
 * 接收到响应
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    
    FileSessionModel *sessionModel = [self getSessionModel:dataTask.taskIdentifier];
    
    // 打开流
    [sessionModel.stream open];
    
    // 获得服务器这次请求 返回数据的总长度
    NSInteger totalLength = [response.allHeaderFields[@"Content-Length"] integerValue] + DownloadLength(sessionModel.url,self.fileName);
    sessionModel.totalLength = totalLength;
    
    // 储存文件信息
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:AttributeFullpath(self.fileName)];
    if (dataDic == nil) dataDic = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"totalLength"] = @(totalLength);
    dict[@"mdUrl"] = FileName(sessionModel.url);
    dict[@"attribute"] = [sessionModel.attribute mutableCopy];
    [dict[@"attribute"] setObject:dict[@"mdUrl"] forKey:@"mdUrl"];
    [dict[@"attribute"] setObject:dict[@"totalLength"] forKey:@"totalLength"];
    [dataDic setObject:dict forKey:FileName(sessionModel.url)];
    [dataDic writeToFile:AttributeFullpath(self.fileName) atomically:YES];
    
    // 存储总长度
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithContentsOfFile:TotalLengthFullpath(self.fileName)];
    if (dict1 == nil) dict1 = [NSMutableDictionary dictionary];
    dict1[FileName(sessionModel.url)] = @(totalLength);
    [dict1 writeToFile:TotalLengthFullpath(self.fileName) atomically:YES];
    
    // 接收这个请求，允许接收服务器的数据
    completionHandler(NSURLSessionResponseAllow);
}

/**
 * 接收到服务器返回的数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    FileSessionModel *sessionModel = [self getSessionModel:dataTask.taskIdentifier];
    
    // 写入数据
    [sessionModel.stream write:data.bytes maxLength:data.length];
    
    // 下载进度
    NSUInteger receivedSize = DownloadLength(sessionModel.url,self.fileName);
    NSUInteger expectedSize = sessionModel.totalLength;
    CGFloat progress = 1.0 * receivedSize / expectedSize;
    
    sessionModel.progressBlock(receivedSize, expectedSize, progress);
}

/**
 * 请求完毕（成功|失败）
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    FileSessionModel *sessionModel = [self getSessionModel:task.taskIdentifier];
    if (!sessionModel) return;
    
    if ([self isCompletion:sessionModel.url fileName:self.fileName]) {
        // 下载完成
        sessionModel.stateBlock(DownloadStateCompleted);
    } else if (error){
        // 下载失败
        sessionModel.stateBlock(DownloadStateFailed);
    }
    
    // 关闭流
    [sessionModel.stream close];
    sessionModel.stream = nil;
    
    // 清除任务
    [self.tasks removeObjectForKey:FileName(sessionModel.url)];
    [self.sessionModels removeObjectForKey:@(task.taskIdentifier).stringValue];
}

#pragma mark - getter
- (NSMutableDictionary *)tasks
{
    if (!_tasks) {
        _tasks = [NSMutableDictionary dictionary];
    }
    return _tasks;
}

- (NSMutableDictionary *)sessionModels
{
    if (!_sessionModels) {
        _sessionModels = [NSMutableDictionary dictionary];
    }
    return _sessionModels;
}


@end

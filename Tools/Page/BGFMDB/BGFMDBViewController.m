//
//  BGFMDBViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/11/15.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "BGFMDBViewController.h"
#import "UITableViewCell+FastCell.h"
#import "NetworkRequest.h"
#import "LiveListModel.h"
#import <QuickLook/QuickLook.h>
#import "UIButton+Alignment.h"

@interface BGFMDBViewController ()<QLPreviewControllerDelegate,QLPreviewControllerDataSource>
@property (nonatomic, strong) UILabel *attTV;

@end

@implementation BGFMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testBGFMDB];
//    [self testAttribute];
    
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 56, 61)];
    saveBtn.backgroundColor = [UIColor redColor];
    [saveBtn setImage:[UIImage imageNamed:@"defaultUserIcon"] forState:(UIControlStateNormal)];
    [saveBtn setTitle:@"查询" forState:(UIControlStateNormal)];
    [saveBtn imageTitleVerticalAlignmentWithSpace:5];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:saveBtn];
    
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(50, 100, self.view.frame.size.width - 100, 200)];
//
//    [self.view addSubview:v];
//
//    [self drawDashLine:v lineWidth:1 lineLength:5 lineSpacing:3 lineColor:[UIColor redColor] fillColor:[UIColor clearColor] cornerRadius:0];
    
    

}


/**
 虚线边框

 @param lineView 需要虚线边框的View
 @param lineWidth 边框宽度
 @param lineLength 边框长度
 @param lineSpacing 边框间距
 @param lineColor 边框颜色
 @param fillColor 填充颜色
 @param cornerRadius 圆角
 */
- (void)drawDashLine:(UIView *)lineView lineWidth:(int)lineWidth lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor cornerRadius:(int)cornerRadius {
    CAShapeLayer *border = [CAShapeLayer layer];
    //边框颜色
    border.strokeColor = lineColor.CGColor;
    //填充的颜色
    border.fillColor = fillColor.CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:lineView.bounds cornerRadius:cornerRadius];
    //设置路径
    border.path = path.CGPath;
    border.frame = lineView.bounds;
    //边框的宽度
    border.lineWidth = lineWidth;
    //设置线条的样式
//    border.lineCap = @"round";
    //虚线的虚线长度与间隔
    border.lineDashPattern = @[@(lineLength), @(lineSpacing)];
    [lineView.layer addSublayer:border];
}




- (void)loadData {
    
    LiveListModel *model = [[LiveListModel alloc] init];
    model.liveId = @"11";
    model.name = @"4566";
    model.industry_name = @"fdgsd";
    [model bg_saveOrUpdate];
    
    LiveListModel *model1 = [[LiveListModel alloc] init];
    model1.liveId = @"12";
    model1.name = @"45667";
    model1.industry_name = @"fdgsd1";
    [model1 bg_saveOrUpdate];
}

- (void)saveBtnClick {
//    NSArray *model = [LiveListModel bg_findAll];
//    NSLog(@"%@",model);
    
    [self testReaderPDF];
}

- (void)deleteBtnClick {
    [LiveListModel bg_drop];
}

- (void)testAttribute {
    
    self.attTV = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
//    self.attTV.backgroundColor = [UIColor redColor];
    self.attTV.numberOfLines = 0;
    [self.view addSubview:self.attTV];
    
    //NSFontAttributeName   字号 UIFont 默认12
    //NSParagraphStyleAttributeName    段落样式  NSParagraphStyle
    //NSForegroundColorAttributeName    前景色   UIColor
    //NSBackgroundColorAttributeName    背景色   UIColor
    //NSObliquenessAttributeName        字体倾斜     NSNumber
    //NSExpansionAttributeName          字体加粗     NSNumber  比例 0就是不变 1增加一倍
    //NSKernAttributeName               字间距   CGFloat
    //NSUnderlineStyleAttributeName     下划线     1或0
    //NSUnderlineColorAttributeName     下划线颜色
    //NSStrikethroughStyleAttributeName 删除线   1或0
    //NSStrikethroughColorAttributeName 某种颜色
    //NSStrokeColorAttributeName        same as ForegroundColor
    //NSStrokeWidthAttributeName        CGFloat
    //NSLigatureAttributeName           连笔字  1或0  没看出效果
    //NSShadowAttributeName             阴影    NSShawdow
    //NSTextEffectAttributeName          设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用：
    //NSAttachmentAttributeName         NSTextAttachment  设置文本附件,常用插入图片
    //NSLinkAttributeName               链接  NSURL (preferred) or NSString
    //NSBaselineOffsetAttributeName     基准线偏移   NSNumber
    
    //NSWritingDirectionAttributeName   文字方向     @[@(1),@(2)]  分别代表不同的文字出现方向等等，我想你一定用不到它 - -
    //NSVerticalGlyphFormAttributeName  水平或者竖直文本  1竖直 0水平 在iOS没卵用，不支持竖版
    
    NSParagraphStyle *paragraph = [[NSParagraphStyle alloc]init];
    NSMutableParagraphStyle *muParagraph = [[NSMutableParagraphStyle alloc]init];
    muParagraph.lineSpacing = 10; // 行距
//    muParagraph.paragraphSpacing = 20; // 段距
    muParagraph.firstLineHeadIndent = 30; // 首行缩进
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[@"asdasdflhjlfsaiollzislooaasdasdflhjlfsaiollzislooaasdasdflhjlfsaiollzislooaasdasdflhjlfsaiollzislooaasdasdflhjlfsaiollzislooaasdasdflhjlfsaiollzislooaasdasdflhjlfsaiollzislooaasdasdflhjlfsaiollzislooaasdasdflhjlfsaiollzislooa" dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    NSRange range = NSMakeRange(0, attrStr.length);
    // 设置字体大小
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:range];
    //字间距
    [attrStr addAttribute:NSKernAttributeName value:@(2) range:range];
    // 字体倾斜
//    [attrStr addAttribute:NSObliquenessAttributeName value:@(1) range:range];
    // 字体加粗
//    [attrStr addAttribute:NSExpansionAttributeName value:@(0.5) range:range];
    // 下划线
    [attrStr addAttribute:NSUnderlineStyleAttributeName value:@(1) range:range];
    [attrStr addAttribute:NSUnderlineColorAttributeName value:[UIColor blueColor] range:range];
    // 删除线
//    [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@(1) range:range];
//    [attrStr addAttribute:NSStrikethroughColorAttributeName value:[UIColor greenColor] range:range];
    
    // 连体字
//    [attrStr addAttribute:NSLigatureAttributeName value:@(1) range:range];
    
    
    // 设置颜色
//    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.942 green:0.611 blue:0.771 alpha:1.000] range:range];
    // 背景色
//    [attrStr addAttribute:NSBackgroundColorAttributeName value:[UIColor colorWithRed:0.475 green:0.482 blue:0.942 alpha:1.000] range:range];
    
    // stroke
//    [attrStr addAttribute:NSStrokeColorAttributeName value:[UIColor blueColor] range:range];
//    [attrStr addAttribute:NSStrokeWidthAttributeName value:@(2) range:range];
    
    // 设置段落样式
    [attrStr addAttribute:NSParagraphStyleAttributeName value:muParagraph range:range];
    
    // 文本方向
//    [attrStr addAttribute:NSVerticalGlyphFormAttributeName value:@(1) range:range];
//    [attrStr addAttribute:NSWritingDirectionAttributeName value:@[@(2),@(3)] range:range];
    
    
    // 阴影
//    NSShadow *shadow = [[NSShadow alloc]init];
//    shadow.shadowOffset = CGSizeMake(2, 2);
//    shadow.shadowColor = [UIColor orangeColor];
//    shadow.shadowBlurRadius = 1;
//    [attrStr addAttribute:NSShadowAttributeName value:shadow range:range];
    
    // 链接
    [attrStr addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.jianshu.com/p/8f49c9c99b21"] range:range];
    
    // 文字中加图片
//    NSTextAttachment *attachment=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
//
//    UIImage *img=[UIImage imageNamed:@"test.png"];
//    attachment.image=img;
//    attachment.bounds=CGRectMake(0, 0, 20, 20);
//    [attrStr addAttribute:NSAttachmentAttributeName value:attachment range:range];
    
    // 基准线偏移
//    [attrStr addAttribute:NSBaselineOffsetAttributeName value:@(50) range:range];
    
    self.attTV.attributedText = attrStr;
}

- (void)testBGFMDB {
    [self loadData];
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    saveBtn.backgroundColor = [UIColor redColor];
    [saveBtn setTitle:@"查询" forState:(UIControlStateNormal)];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:saveBtn];
//
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    deleteBtn.backgroundColor = [UIColor redColor];
    [deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:deleteBtn];
}

- (void)testReaderPDF {
    QLPreviewController * qlPreview = [[QLPreviewController alloc]init];
    qlPreview.dataSource = self; //需要打开的文件的信息要实现dataSource中的方法
    qlPreview.delegate = self;  //视图显示的控制
    [self presentViewController:qlPreview animated:YES completion:nil];
}

-(NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1; //需要显示的文件的个数
}
-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    //返回要打开文件的地址，包括网络或者本地的地址
    NSURL *url = [NSURL URLWithString:@"http://web.touyanshe.com.cn/touyanshe_web/outImages/20171127/20171127_8959205.pdf"];
    return url;
}



@end

//
//  CLWeeklyCalendarView.m
//  Deputy
//
//  Created by Caesar on 30/10/2014.
//  Copyright (c) 2014 Caesar Li. All rights reserved.
//

#import "CLWeeklyCalendarView.h"
#import "DailyCalendarView.h"
#import "DayTitleLabel.h"
#import "NSDate+CL.h"
#import "UIColor+CL.h"
#import "NSDictionary+CL.h"
#import "UIImage+CL.h"

#define WEEKLY_VIEW_COUNT 7
#define DAY_TITLE_VIEW_HEIGHT 30.f
#define DAY_TITLE_FONT_SIZE 14.f
#define DATE_TITLE_MARGIN_TOP 22.f

#define DATE_VIEW_MARGIN 3.f
#define DATE_VIEW_HEIGHT 45.f


#define DATE_LABEL_MARGIN_LEFT 9.f
#define DATE_LABEL_INFO_WIDTH 160.f
#define DATE_LABEL_INFO_HEIGHT 40.f

#define WEATHER_ICON_WIDTH 20
#define WEATHER_ICON_HEIGHT 20
#define WEATHER_ICON_LEFT 90
#define WEATHER_ICON_MARGIN_TOP 9

//Attribute Keys
NSString *const CLCalendarWeekStartDay = @"CLCalendarWeekStartDay";
NSString *const CLCalendarDayTitleTextColor = @"CLCalendarDayTitleTextColor";
NSString *const CLCalendarSelectedDatePrintFormat = @"CLCalendarSelectedDatePrintFormat";
NSString *const CLCalendarSelectedDatePrintColor = @"CLCalendarSelectedDatePrintColor";
NSString *const CLCalendarSelectedDatePrintFontSize = @"CLCalendarSelectedDatePrintFontSize";
NSString *const CLCalendarBackgroundImageColor = @"CLCalendarBackgroundImageColor";

//Default Values
static NSInteger const CLCalendarWeekStartDayDefault = 1;
static NSInteger const CLCalendarDayTitleTextColorDefault = 0xC2E8FF;
static NSString* const CLCalendarSelectedDatePrintFormatDefault = @"EEE, d MMM yyyy";
static float const CLCalendarSelectedDatePrintFontSizeDefault = 13.f;


@interface CLWeeklyCalendarView()<DailyCalendarViewDelegate, UIGestureRecognizerDelegate, CAAnimationDelegate>
@property (nonatomic, strong) UIView *dailySubViewContainer;
@property (nonatomic, strong) UIView *dayTitleSubViewContainer;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *dailyInfoSubViewContainer;
@property (nonatomic, strong) UIImageView *weatherIcon;

//月
@property (nonatomic, strong) UILabel *dateInfoLabel;
/** 年份 */
@property (nonatomic, strong) UILabel *yearLabel;
/** 选择日期 */
@property (nonatomic, strong) UIView *chooseDateView;
/** <#注释#> */
@property (nonatomic, strong) DayTitleLabel *dayTitleLabel;


@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSDictionary *arrDailyWeather;



@property (nonatomic, strong) NSNumber *weekStartConfig;
@property (nonatomic, strong) UIColor *dayTitleTextColor;
@property (nonatomic, strong) NSString *selectedDatePrintFormat;
@property (nonatomic, strong) UIColor *selectedDatePrintColor;
@property (nonatomic) float selectedDatePrintFontSize;
@property (nonatomic, strong) UIColor *backgroundImageColor;

@end

@implementation CLWeeklyCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.backgroundImageView];
        self.arrDailyWeather = @{};
    }
    return self;
}

-(void)setDelegate:(id<CLWeeklyCalendarViewDelegate>)delegate
{
    _delegate = delegate;
    [self applyCustomDefaults];
}

-(void)applyCustomDefaults
{
    NSDictionary *attributes;
    
    if ([self.delegate respondsToSelector:@selector(CLCalendarBehaviorAttributes)]) {
        attributes = [self.delegate CLCalendarBehaviorAttributes];
    }
    
    self.weekStartConfig = attributes[CLCalendarWeekStartDay] ? attributes[CLCalendarWeekStartDay] : [NSNumber numberWithInt:CLCalendarWeekStartDayDefault];
    
    self.dayTitleTextColor = attributes[CLCalendarDayTitleTextColor]? attributes[CLCalendarDayTitleTextColor]:[UIColor colorWithHex:CLCalendarDayTitleTextColorDefault];
    
    self.selectedDatePrintFormat = attributes[CLCalendarSelectedDatePrintFormat]? attributes[CLCalendarSelectedDatePrintFormat] : CLCalendarSelectedDatePrintFormatDefault;
    
    self.selectedDatePrintColor = attributes[CLCalendarSelectedDatePrintColor]? attributes[CLCalendarSelectedDatePrintColor] : [UIColor whiteColor];
    
    self.selectedDatePrintFontSize = attributes[CLCalendarSelectedDatePrintFontSize]? [attributes[CLCalendarSelectedDatePrintFontSize] floatValue] : CLCalendarSelectedDatePrintFontSizeDefault;
    
//    NSLog(@"%@  %f", attributes[CLCalendarBackgroundImageColor],  self.selectedDatePrintFontSize);
    self.backgroundImageColor = attributes[CLCalendarBackgroundImageColor];
    
    [self setNeedsDisplay];
}

#pragma mark - 懒加载
-(UIView *)dailyInfoSubViewContainer
{
    if(!_dailyInfoSubViewContainer){
        _dailyInfoSubViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 45)];
        
        _dailyInfoSubViewContainer.backgroundColor = [UIColor whiteColor];
        _dailyInfoSubViewContainer.userInteractionEnabled = YES;
        
//        [_dailyInfoSubViewContainer addSubview:self.weatherIcon];
        //月的label
        [_dailyInfoSubViewContainer addSubview:self.dateInfoLabel];
        //年的label
        [_dailyInfoSubViewContainer addSubview:self.yearLabel];
        //选择按钮
        [_dailyInfoSubViewContainer addSubview:self.chooseDateView];
        
//        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dailyInfoViewDidClick:)];
//        [_dailyInfoSubViewContainer addGestureRecognizer:singleFingerTap];
    }
    return _dailyInfoSubViewContainer;
}
-(UIImageView *)weatherIcon
{
    if(!_weatherIcon){
        _weatherIcon = [[UIImageView alloc] initWithFrame:CGRectMake(WEATHER_ICON_LEFT, WEATHER_ICON_MARGIN_TOP, WEATHER_ICON_WIDTH, WEATHER_ICON_HEIGHT)];
    }
    return _weatherIcon;
}
-(UILabel *)dateInfoLabel
{
    if(!_dateInfoLabel){
        _dateInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 14, 50, 20)];
        _dateInfoLabel.textAlignment = NSTextAlignmentRight;
    }
//    _dateInfoLabel.backgroundColor = [UIColor redColor];
    _dateInfoLabel.font = [UIFont systemFontOfSize:20];
    _dateInfoLabel.textColor = [UIColor orangeColor];
    return _dateInfoLabel;
}
- (UILabel *)yearLabel {
    if (!_yearLabel) {
        _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 16, 60, 17)];
        _yearLabel.textAlignment = NSTextAlignmentLeft;
    }
    _yearLabel.font = [UIFont systemFontOfSize:14];
    _yearLabel.textColor =  [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
    
    return _yearLabel;
}

- (UIView *)chooseDateView {
    if (!_chooseDateView) {
        _chooseDateView = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 54, 10, 44, 24)];
        _chooseDateView.backgroundColor = [UIColor whiteColor];
        UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 18, 18)];
        image1.image = [UIImage imageNamed:@"tys_tc_drop"];
        image1.userInteractionEnabled = YES;
        [_chooseDateView addSubview:image1];
        
        UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 20, 20)];
        image2.image = [UIImage imageNamed:@"tys_tc_calendar_black"];
        image2.userInteractionEnabled = YES;
        [_chooseDateView addSubview:image2];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDateClick:)];
        [_chooseDateView addGestureRecognizer:tap];
    }
    return _chooseDateView;
}


-(UIView *)dayTitleSubViewContainer
{
    //
    if(!_dayTitleSubViewContainer){
        _dayTitleSubViewContainer = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45, self.bounds.size.width, 30)];
        _dayTitleSubViewContainer.userInteractionEnabled = YES;
    }
    return _dayTitleSubViewContainer;
    
}

-(UIView *)dailySubViewContainer
{
    if(!_dailySubViewContainer) {
        _dailySubViewContainer = [[UIImageView alloc] initWithFrame:CGRectMake(0, 75, self.bounds.size.width, 50)];
        _dailySubViewContainer.backgroundColor = [UIColor clearColor];
        _dailySubViewContainer.userInteractionEnabled = YES;
        
    }
    return _dailySubViewContainer;
}

/*******************************************************************/
- (UIImageView *)backgroundImageView
{
    if(!_backgroundImageView){
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _backgroundImageView.userInteractionEnabled = YES;
        
        [_backgroundImageView addSubview:self.dailyInfoSubViewContainer];
        //周一至周日title
        [_backgroundImageView addSubview:self.dayTitleSubViewContainer];
        //日期
        [_backgroundImageView addSubview:self.dailySubViewContainer];
        
        
        
        //Apply swipe gesture
        UISwipeGestureRecognizer *recognizerRight;
        recognizerRight.delegate=self;
        
        recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
        [recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [_backgroundImageView addGestureRecognizer:recognizerRight];
        
        
        UISwipeGestureRecognizer *recognizerLeft;
        recognizerLeft.delegate=self;
        recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
        [recognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [_backgroundImageView addGestureRecognizer:recognizerLeft];
    }
    
    _backgroundImageView.backgroundColor = self.backgroundImageColor ? self.backgroundImageColor : [UIColor colorWithPatternImage:[UIImage calendarBackgroundImage:self.bounds.size.height]];
    
    
    return _backgroundImageView;
}
-(void)initDailyViews
{
    CGFloat dailyWidth = self.bounds.size.width/WEEKLY_VIEW_COUNT;
    NSDate *today = [NSDate new];
    NSDate *dtWeekStart = [today getWeekStartDate:self.weekStartConfig.integerValue];
    self.startDate = dtWeekStart;
    for (UIView *v in [self.dailySubViewContainer subviews]){
        [v removeFromSuperview];
    }
    for (UIView *v in [self.dayTitleSubViewContainer subviews]){
        [v removeFromSuperview];
    }
    
    for(int i = 0; i < WEEKLY_VIEW_COUNT; i++){
        NSDate *dt = [dtWeekStart addDays:i];
        
        [self dayTitleViewForDate: dt inFrame: CGRectMake(dailyWidth*i, 0, dailyWidth, DAY_TITLE_VIEW_HEIGHT)];
        
        
        [self dailyViewForDate:dt inFrame: CGRectMake(dailyWidth*i, 0, dailyWidth, DATE_VIEW_HEIGHT) ];
        
        self.endDate = dt;
    }
    
    [self dailyCalendarViewDidSelect:[NSDate new]];
}

-(UILabel *)dayTitleViewForDate:(NSDate *)date inFrame:(CGRect)frame
{
    DayTitleLabel *dayTitleLabel = [[DayTitleLabel alloc] initWithFrame:frame];
//    dayTitleLabel.backgroundColor = [UIColor clearColor];
    
    dayTitleLabel.textAlignment = NSTextAlignmentCenter;
    dayTitleLabel.font = [UIFont systemFontOfSize:14];
    
    NSString *week = [[date getDayOfWeekShortString] uppercaseString];
    NSString *weekStr = [week substringWithRange:NSMakeRange(1, 1)];
    dayTitleLabel.text = weekStr;
 
    dayTitleLabel.date = date;
 
    dayTitleLabel.userInteractionEnabled = YES;
    
    self.dayTitleLabel = dayTitleLabel;
    if ([self.dayTitleLabel.text isEqualToString:@"日"] || [self.dayTitleLabel.text isEqualToString:@"六"]) {
        self.dayTitleLabel.textColor = [UIColor lightGrayColor];
    }
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dayTitleViewDidClick:)];
    [self.dayTitleLabel addGestureRecognizer:singleFingerTap];
    
    [self.dayTitleSubViewContainer addSubview:self.dayTitleLabel];
    return dayTitleLabel;
}

#pragma mark - button点击事件
- (void)chooseDateClick:(UITapGestureRecognizer *)tap {
    if (self.selectTap) {
        self.selectTap(tap);
    }
}

- (DailyCalendarView *)dailyViewForDate: (NSDate *)date inFrame: (CGRect)frame
{
    DailyCalendarView *view = [[DailyCalendarView alloc] initWithFrame:frame];
    view.date = date;
    view.backgroundColor = [UIColor clearColor];
    view.delegate = self;
    [self.dailySubViewContainer addSubview:view];
    return view;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [self initDailyViews];
    
}

-(void)markDateSelected:(NSDate *)date
{
    for (DailyCalendarView *v in [self.dailySubViewContainer subviews]){
        [v markSelected:([v.date isSameDateWith:date])];
    }
    self.selectedDate = date;
    
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *strDate = [dayFormatter stringFromDate:date];
    //月份
    NSString *strM = [strDate substringWithRange:NSMakeRange(5, 2)];
    NSString *strY = [strDate substringWithRange:NSMakeRange(0, 4)];
    [self adjustDailyInfoLabelAndWeatherIcon : NO];
    
    
    self.dateInfoLabel.text = [NSString stringWithFormat:@"%@月",strM];
    self.yearLabel.text = [NSString stringWithFormat:@"%@年",strY];
    
    
}
-(void)dailyInfoViewDidClick: (UIGestureRecognizer *)tap
{
    //Click to jump back to today
    [self redrawToDate:[NSDate new] ];
}
-(void)dayTitleViewDidClick: (UIGestureRecognizer *)tap
{
    [self redrawToDate:((DayTitleLabel *)tap.view).date];
}
-(void)redrawToDate:(NSDate *)dt
{
    if(![dt isWithinDate:self.startDate toDate:self.endDate]){
        BOOL swipeRight = ([dt compare:self.startDate] == NSOrderedAscending);
        [self delegateSwipeAnimation:swipeRight blnToday:[dt isDateToday] selectedDate:dt];
    }
    
    [self dailyCalendarViewDidSelect:dt];
}
-(void)redrawCalenderData
{
    [self redrawToDate:self.selectedDate];
    
}
-(void)adjustDailyInfoLabelAndWeatherIcon: (BOOL)blnShowWeatherIcon
{
    self.dateInfoLabel.textAlignment = (blnShowWeatherIcon)?NSTextAlignmentLeft:NSTextAlignmentCenter;
    
    if(blnShowWeatherIcon){
        if([self.selectedDate isDateToday]){
            self.weatherIcon.frame = CGRectMake(WEATHER_ICON_LEFT-20, WEATHER_ICON_MARGIN_TOP, WEATHER_ICON_WIDTH, WEATHER_ICON_HEIGHT);
//            self.dateInfoLabel.frame = CGRectMake(WEATHER_ICON_LEFT+WEATHER_ICON_WIDTH+DATE_LABEL_MARGIN_LEFT-20, 0, DATE_LABEL_INFO_WIDTH, DATE_LABEL_INFO_HEIGHT);
        }else{
//            self.weatherIcon.frame = CGRectMake(WEATHER_ICON_LEFT, WEATHER_ICON_MARGIN_TOP, WEATHER_ICON_WIDTH, WEATHER_ICON_HEIGHT);
//            self.dateInfoLabel.frame = CGRectMake(WEATHER_ICON_LEFT+WEATHER_ICON_WIDTH+DATE_LABEL_MARGIN_LEFT, 0, DATE_LABEL_INFO_WIDTH, DATE_LABEL_INFO_HEIGHT);
        }
    }else{
//        self.dateInfoLabel.frame = CGRectMake( (self.bounds.size.width - DATE_LABEL_INFO_WIDTH)/2, 0, DATE_LABEL_INFO_WIDTH, DATE_LABEL_INFO_HEIGHT);
    }
    
//    self.weatherIcon.hidden = !blnShowWeatherIcon;
}

#pragma swipe
-(void)swipeLeft: (UISwipeGestureRecognizer *)swipe
{
    [self delegateSwipeAnimation: NO blnToday:NO selectedDate:nil];
}
-(void)swipeRight: (UISwipeGestureRecognizer *)swipe
{
    [self delegateSwipeAnimation: YES blnToday:NO selectedDate:nil];
}
-(void)delegateSwipeAnimation: (BOOL)blnSwipeRight blnToday: (BOOL)blnToday selectedDate:(NSDate *)selectedDate
{
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setType:kCATransitionPush];
    [animation setSubtype:(blnSwipeRight)?kCATransitionFromLeft:kCATransitionFromRight];
    [animation setDuration:0.50];
    [animation setTimingFunction:
     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.dailySubViewContainer.layer addAnimation:animation forKey:kCATransition];
    
    NSMutableDictionary *data = @{@"blnSwipeRight": [NSNumber numberWithBool:blnSwipeRight], @"blnToday":[NSNumber numberWithBool:blnToday]}.mutableCopy;
    
    if(selectedDate){
        [data setObject:selectedDate forKey:@"selectedDate"];
    }
    
    [self performSelector:@selector(renderSwipeDates:) withObject:data afterDelay:0.05f];
}

-(void)renderSwipeDates: (NSDictionary*)param
{
    int step = ([[param objectForKey:@"blnSwipeRight"] boolValue])? -1 : 1;
    BOOL blnToday = [[param objectForKey:@"blnToday"] boolValue];
    NSDate *selectedDate = [param objectForKeyWithNil:@"selectedDate"];
    CGFloat dailyWidth = self.bounds.size.width/WEEKLY_VIEW_COUNT;
    
    
    NSDate *dtStart;
    if(blnToday){
        dtStart = [[NSDate new] getWeekStartDate:self.weekStartConfig.integerValue];
    }else{
        dtStart = (selectedDate)? [selectedDate getWeekStartDate:self.weekStartConfig.integerValue]:[self.startDate addDays:step*7];
    }
    
    self.startDate = dtStart;
    for (UIView *v in [self.dailySubViewContainer subviews]){
        [v removeFromSuperview];
    }
    
    for(int i = 0; i < WEEKLY_VIEW_COUNT; i++){
        NSDate *dt = [dtStart addDays:i];
        
        DailyCalendarView *view = [self dailyViewForDate:dt inFrame: CGRectMake(dailyWidth*i, 0, dailyWidth, DATE_VIEW_HEIGHT) ];
        DayTitleLabel *titleLabel = [[self.dayTitleSubViewContainer subviews] objectAtIndex:i];
        titleLabel.date = dt;
        
        [view markSelected:([view.date isSameDateWith:self.selectedDate])];
        self.endDate = dt;
    }
}

-(void)updateWeatherIconByKey:(NSString *)key
{
    if(!key){
        [self adjustDailyInfoLabelAndWeatherIcon:NO];
        return;
    }
    
    self.weatherIcon.image = [UIImage imageNamed:key];
    [self adjustDailyInfoLabelAndWeatherIcon:YES];
}

#pragma DeputyDailyCalendarViewDelegate
-(void)dailyCalendarViewDidSelect:(NSDate *)date
{
    [self markDateSelected:date];
    
    [self.delegate dailyCalendarViewDidSelect:date];
}

@end

//
//  ZXCalendarView.m
//  sdfdsf
//
//  Created by 张玺 on 12-11-25.
//  Copyright (c) 2012年 张玺. All rights reserved.
//

#define kWidth 45.714f

#import "ZXCalendarView.h"

@implementation ZXCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        calendar = [NSCalendar currentCalendar];
        [calendar setTimeZone:[NSTimeZone localTimeZone]];
        
        [self initTitle];
        
        year = 2012;
        month = 11;
        
        monthView = [[ZXCalendarMonthView alloc] initWithYear:year andMonth:month withFrame:CGRectMake(0, 75, 320, 346)];
        monthView.delegate = self;
        [self addSubview:monthView];
    }
    return self;
}
-(void)initTitle
{
    title = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 160, 54)];
    title.font = [UIFont systemFontOfSize:26];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor colorWithRed:47/255.0 green:59/255.0 blue:75/255.0 alpha:1];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"2012-12";
    [self addSubview:title];
    
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(20, 7, 44, 44);
    UIImage *leftBg = [UIImage imageWithContentsOfFile:[self pathForResource:@"left" ofType:@"png"]];
    [left setImage:leftBg forState:UIControlStateNormal];
    [left addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:left];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(256, 7, 44, 44);
    UIImage *rightBg = [UIImage imageWithContentsOfFile:[self pathForResource:@"right" ofType:@"png"]];
    [right setImage:rightBg forState:UIControlStateNormal];
    [right addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:right];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 52, 320, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    
    for(int i = 0;i<7;i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*kWidth, 54, kWidth, 20)];
        label.font = [UIFont systemFontOfSize:12];
        label.backgroundColor = [UIColor clearColor];
        //title.textColor = [UIColor colorWithRed:47/255.0 green:59/255.0 blue:75/255.0 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = [NSString stringWithFormat:@"周%d",i+1];
        [self addSubview:label];
    }
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 74, 320, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [self addSubview:line2];
    
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];
}

-(void)swipe:(UISwipeGestureRecognizer *)swipe
{
    NSLog(@"%@",swipe);
    if(swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        [self right];
    }
    if(swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self left];
    }
}
-(void)left
{
    if(month == 1)
    {
        year --;
        month = 12;
    }else
        month --;

   ZXCalendarMonthView *newMonth = [[ZXCalendarMonthView alloc] initWithYear:year andMonth:month withFrame:CGRectMake(-320, 75, 320, 346)];
    newMonth.delegate = self;
    [self addSubview:newMonth];
    [UIView animateWithDuration:0.4
                     animations:^{
                         CGRect frame = monthView.frame;
                         newMonth.frame = frame;
                         frame.origin.x+=320;
                         monthView.frame = frame;
                     } completion:^(BOOL finished) {
                         [monthView removeFromSuperview];
                         monthView = newMonth;
                     }];
    
}
-(void)right
{
    if(month == 12)
    {
        year ++;
        month = 1;
    }else
        month ++;
    
    ZXCalendarMonthView *newMonth = [[ZXCalendarMonthView alloc] initWithYear:year andMonth:month withFrame:CGRectMake(320, 75, 320, 346)];
        newMonth.delegate = self;
    [self addSubview:newMonth];
    [UIView animateWithDuration:0.4
                     animations:^{
                         CGRect frame = monthView.frame;
                         newMonth.frame = frame;
                         frame.origin.x-=320;
                         monthView.frame = frame;
                     } completion:^(BOOL finished) {
                         [monthView removeFromSuperview];
                         monthView = newMonth;
                     }];
}
-(void)calendar:(ZXCalendarMonthView *)monthView didSelectDate:(NSDate *)date
{
    _selectedDate = date;
}
-(void)initData
{

}

-(NSString *)pathForResource:(NSString *)name ofType:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZXCalendarView" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    return [bundle pathForResource:name ofType:type];
}



@end

@implementation ZXCalendarMonthView

- (id)initWithYear:(int)theYear andMonth:(int)theMonth withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        calendar = [NSCalendar currentCalendar];
        [calendar setTimeZone:[NSTimeZone localTimeZone]];
        NSDate *start = [self startDateWithYear:theYear andMonth:theMonth];
        days = [NSMutableArray array];
        NSLog(@"%@",start);
        for(int i = 0;i<=41;i++)
        {
            ZXCalendarDayView *day = [[ZXCalendarDayView alloc]initWithDate:[start dateByAddingTimeInterval:i*24*60*60] withMonth:theMonth withIndex:i];
            [days addObject:day];
            [self addSubview:day];
        }
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)tap:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self];
    
    int x = point.x/kWidth;
    int y = point.y/kWidth;
    int index = 7*y+x;
    

    for(int i=0;i<days.count;i++)
    {
        ZXCalendarDayView *day = days[i];
        
        if(i == index)
           [day setBgImageViewType:cSelect];
        else
           [day setBgImageViewType:cNormal];
    }

}
-(NSDate *)startDateWithYear:(int)theYear andMonth:(int)theMonth
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    [c setTimeZone:[NSTimeZone localTimeZone]];
    [c setYear:theYear];
    [c setMonth:theMonth];
    [c setDay:1];
    NSDate *firstDay = [calendar dateFromComponents:c];
    NSLog(@"first,%@",firstDay);
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:firstDay];
    int weekday = [components weekday];
    NSDate *start = [NSDate dateWithTimeInterval:-24*60*60*(weekday-1) sinceDate:firstDay];
    
    return start;
}


@end

@implementation ZXCalendarDayView

- (id)initWithDate:(NSDate *)theDate withMonth:(int)theMonth withIndex:(int)index
{
    self = [super initWithFrame:[self frameWithIndex:index]];
    if (self) {
        calendar = [NSCalendar currentCalendar];
        [calendar setTimeZone:[NSTimeZone localTimeZone]];
        
        date = theDate;
        month = theMonth;
        
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, kWidth)];
        label.font = [UIFont systemFontOfSize:20];
        label.backgroundColor = [UIColor clearColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = [NSString stringWithFormat:@"%d",[self day:date]];
        
        
        
        if([self isToday])
        {
            //今天
            type = cToday;
            //self.backgroundColor = [UIColor redColor];

        }else if([self month:theDate] != theMonth)
        {
            //非本月的日期
            type = cOther;
           label.textColor = [UIColor grayColor];
            //self.backgroundColor = [UIColor greenColor];

        }else
        {
            //本月的普通日期
            type = cNormal;
        }
        
        [self setBgImageViewType:type];
        [self addSubview:label];
        
        

        
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//        [self addGestureRecognizer:tap];
        


    }
    return self;
}
-(void)tap
{
    NSLog(@"%@",date);
    [self setBgImageViewType:cSelect];
}
-(int)month:(NSDate *)theDate
{
    NSDateComponents *components = [calendar components:NSMonthCalendarUnit fromDate:theDate];
    return [components month];
}
-(int)day:(NSDate *)theDate
{
    NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:theDate];
    return [components day];
}

-(BOOL)isToday
{
    int day    =  [self day:date];
    int today  =  [self day:[NSDate date]];
    
    return (day == today)&&(month == [self month:[NSDate date]]);
}

-(CGRect)frameWithIndex:(int)index
{
    float x = (index%7)*kWidth;
    float y = (index/7)*kWidth;
    return CGRectMake(x, y, kWidth, kWidth);
}
-(void)setBgImageViewType:(ZXCalendarDayType)theType
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZXCalendarView" ofType:@"bundle"];
    NSString *name;
    switch (theType) {
        case cToday:
            name = @"day_selected";
            break;
        case cNormal:
            name = @"day_bg";
            break;
        case cOther:
            name = @"day_bg";
            break;
        case cSelect:
            name = @"day_selected";
            break;
        default:
            break;
    }
    
    
    UIImage *bg = [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:path] pathForResource:name ofType:@"png"]];
    if(bgView == nil)
    {
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,kWidth,kWidth)];
    [self addSubview:bgView];
    }
    bgView.image = bg;
}

@end

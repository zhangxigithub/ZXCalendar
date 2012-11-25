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
        self.backgroundColor = [UIColor grayColor];
        calendar = [NSCalendar currentCalendar];
        [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        [self initTitle];
        
        
        
        monthView = [[ZXCalendarMonthView alloc] initWithYear:2012 andMonth:11 withFrame:CGRectMake(0, 44, 320, 320)];

        [self addSubview:monthView];
    }
    return self;
}
-(void)initTitle
{
    title = [[UILabel alloc] initWithFrame:CGRectMake(80, 2, 160, 22)];
    title.font = [UIFont systemFontOfSize:22];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor colorWithRed:47/255.0 green:59/255.0 blue:75/255.0 alpha:1];
    
    title.textAlignment = NSTextAlignmentCenter;
    
    title.text = @"2012-12";
    [self addSubview:title];
    
    
    for(int i = 0;i<7;i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*kWidth, 24, kWidth, 20)];
        label.font = [UIFont systemFontOfSize:12];
        label.backgroundColor = [UIColor clearColor];
        //title.textColor = [UIColor colorWithRed:47/255.0 green:59/255.0 blue:75/255.0 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = [NSString stringWithFormat:@"周%d",i+1];
        [self addSubview:label];
    }
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 44, 44);
    [left setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:left];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(276, 0, 44, 44);
    [right setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:right];
}
-(void)left
{
    NSLog(@"left");
    
}
-(void)right
{
    NSLog(@"right");
}
-(void)initData
{

}



@end

@implementation ZXCalendarMonthView

- (id)initWithYear:(int)theYear andMonth:(int)theMonth withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        calendar = [NSCalendar currentCalendar];
        [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSDate *start = [self startDateWithYear:theYear andMonth:theMonth];
        
        NSLog(@"%@",start);
        for(int i = 0;i<=41;i++)
        {
            ZXCalendarDayView *day = [[ZXCalendarDayView alloc]initWithDate:[start dateByAddingTimeInterval:i*24*60*60] withMonth:theMonth withIndex:i];
            [self addSubview:day];
        }
        

        
        
    }
    return self;
}
-(NSDate *)startDateWithYear:(int)theYear andMonth:(int)theMonth
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    [c setYear:theYear];
    [c setMonth:theMonth];
    [c setDay:1];
    NSDate *firstDay = [calendar dateFromComponents:c];
    
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
        [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        date = theDate;
        month = theMonth;
        
        
        if([self isToday])
        {
            //今天
            type = cToday;
            self.backgroundColor = [UIColor redColor];
        }else if([self month:theDate] != theMonth)
        {
            //非本月的日期
            type = cOther;
            self.backgroundColor = [UIColor greenColor];
        }else
        {
            //本月的普通日期
            type = cNormal;
            self.backgroundColor = [UIColor purpleColor];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, kWidth)];
        label.font = [UIFont systemFontOfSize:16];
        label.backgroundColor = [UIColor clearColor];

        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = [NSString stringWithFormat:@"%d",[self day:date]];
        [self addSubview:label];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
        


    }
    return self;
}
-(void)tap
{
    NSLog(@"%@",date);
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


@end

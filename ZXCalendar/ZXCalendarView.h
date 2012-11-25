//
//  ZXCalendarView.h
//  sdfdsf
//
//  Created by 张玺 on 12-11-25.
//  Copyright (c) 2012年 张玺. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXCalendarMonthView;
@class ZXCalendarDayView;

@interface ZXCalendarView : UIView
{
    NSCalendar *calendar;
    UILabel *title;
    ZXCalendarMonthView *monthView;
}

@end




@interface ZXCalendarMonthView : UIView
{
    NSCalendar *calendar;
    int year;
    int month;

}
- (id)initWithYear:(int)theYear andMonth:(int)theMonth withFrame:(CGRect)frame;
@end

typedef enum
{
    cToday,
    cNormal,
    cOther
}ZXCalendarDayType;
@interface ZXCalendarDayView : UIView
{
    NSCalendar *calendar;
    int month;
    NSDate *date;
        ZXCalendarDayType type;
}

- (id)initWithDate:(NSDate *)theDate withMonth:(int)theMonth withIndex:(int)index;

@end








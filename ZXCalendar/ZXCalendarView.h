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


@protocol ZXCalendarMonthViewDelegate
-(void)calendar:(ZXCalendarMonthView*)monthView didSelectDate:(NSDate*)date;
@end


@interface ZXCalendarView : UIView<ZXCalendarMonthViewDelegate>
{
    NSCalendar *calendar;
    UILabel *title;
    ZXCalendarMonthView *monthView,*leftMonth,*rightMonth;
    int year,month;
}
@property(nonatomic,strong) NSDate *selectedDate;
@end




@interface ZXCalendarMonthView : UIView
{
    NSCalendar *calendar;
    int year;
    int month;
    NSMutableArray *days;
}
@property(nonatomic,unsafe_unretained) id<ZXCalendarMonthViewDelegate>delegate;
- (id)initWithYear:(int)theYear andMonth:(int)theMonth withFrame:(CGRect)frame;
@end

typedef enum
{
    cToday,
    cNormal,
    cOther,
    cSelect
}ZXCalendarDayType;
@interface ZXCalendarDayView : UIView
{
    UIImageView *bgView;
    NSCalendar *calendar;
    int month;
    NSDate *date;
    UILabel *label;
    ZXCalendarDayType type;
}

- (id)initWithDate:(NSDate *)theDate withMonth:(int)theMonth withIndex:(int)index;
-(void)setBgImageViewType:(ZXCalendarDayType)theType;
@end








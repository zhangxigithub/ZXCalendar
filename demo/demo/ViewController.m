//
//  ViewController.m
//  demo
//
//  Created by 张玺 on 12-11-26.
//  Copyright (c) 2012年 张玺. All rights reserved.
//

#import "ViewController.h"
#import "ZXCalendarView.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ZXCalendarView *calendar = [[ZXCalendarView alloc] initWithFrame:CGRectMake(0, 0, 320, 346)];
    [self.view addSubview:calendar];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

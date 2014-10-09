//
//  AnalyticsViewController.m
//  Nyussz
//
//  Created by Petra Donka on 10/08/14.
//  Copyright (c) 2014 Petra Donka. All rights reserved.
//

#import "AnalyticsViewController.h"
#import <PNChart.h>
#import <Parse/Parse.h>

@implementation AnalyticsViewController

- (void)viewDidLoad
{
    
}

- (void)historyQuery
{
    PFQuery *historyQuery = [[PFQuery alloc] initWithClassName:@"History"];
    [historyQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *object in objects) {
            
        }
    }];
}

- (void)testLineChart
{
    //For LineChart
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:_chartView.frame];
    [lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    
    // Line Chart No.1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
    [_chartView addSubview:lineChart];

}

@end

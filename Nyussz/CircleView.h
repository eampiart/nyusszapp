//
//  CircleView.h
//  Nyussz
//
//  Created by Petra Donka on 10/08/14.
//  Copyright (c) 2014 Petra Donka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

@property CAShapeLayer *backgroundRingLayer;
@property CAShapeLayer *foregroundRingLayer;
@property UIImageView *imageView;
@property UILabel *centerLabel;
@property NSString *labelString;
@property NSString *imageName;
@property CGFloat *lineWidth;
@property UIColor *backgroundLineColor;
@property UIColor *foregroundLineColor;
@property CGFloat *strokeEndFloat;

@end

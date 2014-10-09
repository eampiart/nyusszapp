//
//  LoginViewController.m
//  Nyussz
//
//  Created by Petra Donka on 05/08/14.
//  Copyright (c) 2014 Petra Donka. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Nyussz Login";
    [label sizeToFit];
    self.logInView.logo = label;
    
    self.logInView.usernameField.placeholder = @"username";
    self.logInView.passwordField.placeholder = @"password";
    
    self.logInView.usernameField.textColor = [UIColor blackColor];
    self.logInView.passwordField.textColor = [UIColor blackColor];

    
    CALayer *layer = self.logInView.usernameField.layer;
    layer.shadowOpacity = 0.0;
    layer = self.logInView.passwordField.layer;
    layer.shadowOpacity = 0.0;
    
    // Do any additional setup after loading the view.
}

@end

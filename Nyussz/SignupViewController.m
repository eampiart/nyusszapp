//
//  SignupViewController.m
//  Nyussz
//
//  Created by Petra Donka on 05/08/14.
//  Copyright (c) 2014 Petra Donka. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Nyussz Signup";
    [label sizeToFit];
    self.signUpView.logo = label;
    self.signUpView.usernameField.placeholder = @"username";
//    self.signUpView.usernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"username"];
    self.signUpView.usernameField.textColor = [UIColor blackColor];
    self.signUpView.passwordField.textColor = [UIColor blackColor];

    
    //remove text shadow
    CALayer *layer = self.signUpView.usernameField.layer;
    layer.shadowOpacity = 0.0;
    layer = self.signUpView.passwordField.layer;
    layer.shadowOpacity = 0.0;

    
    self.signUpView.passwordField.placeholder = @"password";
    
    // Do any additional setup after loading the view.
}


@end

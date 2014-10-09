//
//  ViewController.m
//  Nyussz
//
//  Created by Petra Donka on 05/08/14.
//  Copyright (c) 2014 Petra Donka. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "SignupViewController.h"
#import "HistoryTableViewController.h"

@interface ViewController () <UIAlertViewDelegate, PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate>
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setUpNyusszantasView];

    [self setUpAfterUserLogInOut];
}

- (void)setUpAfterUserLogInOut
{
    if ([PFUser currentUser] != nil) {
//        PFUser *currentUser = [PFUser currentUser];
//        self.usernameLabel.text = currentUser.username;
        self.signUpButton.enabled = NO;
        self.signUpButton.alpha = 0;
        self.logInButton.enabled = NO;
        self.logInButton.alpha = 0;
    } else {
//        self.usernameLabel.text = @"pleease log in";
        self.signUpButton.enabled = YES;
        self.signUpButton.alpha = 1;
        self.logInButton.enabled = YES;
        self.logInButton.alpha = 1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Views
//- (void)setUpNyusszantasView
//{
//
//}

#pragma mark - Buttons, Actions
- (IBAction)signUpButtonPressed:(id)sender
{
    SignupViewController *signUpController = [[SignupViewController alloc] init];
    signUpController.delegate = self;
    signUpController.fields = PFSignUpFieldsUsernameAndPassword|PFSignUpFieldsDismissButton;
    [self presentViewController:signUpController animated:YES completion:nil];
}

- (IBAction)loginButtonPressed:(id)sender
{
    LoginViewController *logInController = [[LoginViewController alloc] init];
    logInController.signUpController = [[SignupViewController alloc] init];
    logInController.delegate = self;
    logInController.fields = PFLogInFieldsUsernameAndPassword|PFLogInFieldsDismissButton;
    [self presentViewController:logInController animated:YES completion:nil];
}

- (IBAction)tripleTapGestureRecognized:(id)sender
{
    NSLog(@"gest recognized");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sign out" message:@"Are you sure you want to sign out?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alertView show];
}

- (IBAction)navBarHistoryButtonPressed:(id)sender
{
    HistoryTableViewController *historyTableViewController = [[HistoryTableViewController alloc] initWithClassName:@"History"];
    //    [self presentViewController:historyTableViewController animated:YES completion:nil];
    [self.navigationController pushViewController:historyTableViewController animated:YES];
}

- (IBAction)navBarChartButtonPressed:(id)sender
{
    
}

- (IBAction)nyusszButtonPressed:(id)sender
{
    [self sendNyusszantas];
//    PFPush *push = [[PFPush alloc] init];
////    [push setMessage:@"Nyuszi megnyusszantott!"];
//    [push setData:@{@"sound":@"default", @"badge":@"increment",@"alert":@"Nyuszi megnyusszantott!"}];
//    [push setChannel:@"nyuszik"];
//    [push sendPushInBackground];
}
- (IBAction)nyusszogtatasButtonPressed:(id)sender
{
    [self sendNyusszogas];
}

#pragma mark - Parse Methods
- (void)pushToAllExceptMe
{
    //find all users other than currentUser
    PFQuery *userQuery = [PFUser query];
    PFUser *currentUser = [PFUser currentUser];
    [userQuery whereKey:@"username" notEqualTo:currentUser.username];
    
    //    //find installations (devices) for all users other than the current one
    //    PFQuery *pushQuery = [PFInstallation query];
    //    [pushQuery whereKey:@"user" matchesQuery:userQuery];
    
    //    //send push
    //    PFPush *push = [[PFPush alloc] init];
    //    [push setQuery:pushQuery];
    //    [push setData:@{@"sound":@"default", @"badge":@"increment",@"alert":@"Nyuszi megnyusszantott!"}];
    //    [push sendPushInBackground];
    
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFUser *user in objects) {
            PFPush *push = [[PFPush alloc] init];
            PFQuery *pushUserQuery = [PFInstallation query];
            [pushUserQuery whereKey:@"user" equalTo:user];
            
            [push setQuery:pushUserQuery];
            NSString *msg = [NSString stringWithFormat:@"Nyusszantás (from %@)!", currentUser.username];
            [push setData:@{@"sound":@"default", @"badge":@"increment",@"alert":msg}];
            [push sendPushInBackground];
            
            NSLog(@"Push sent to %@",user.username);
        }
    }];
}

- (void)sendNyusszantas
{
    //find all users other than currentUser
    PFQuery *userQuery = [PFUser query];
    PFUser *currentUser = [PFUser currentUser];
    [userQuery whereKey:@"username" notEqualTo:currentUser.username];
    
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFUser *user in objects) {
            PFPush *push = [[PFPush alloc] init];
            PFQuery *pushUserQuery = [PFInstallation query];
            [pushUserQuery whereKey:@"user" equalTo:user];
            
            [push setQuery:pushUserQuery];
            NSString *msg = [NSString stringWithFormat:@"Megnyusszantott! 👋"];
            [push setData:@{@"sound":@"default", @"badge":@"increment",@"alert":msg}];
            [push sendPushInBackground];
            
            NSLog(@"Push sent to %@",user.username);
        }
    }];
    
    PFObject *nyusszantas = [PFObject objectWithClassName:@"History"];
    nyusszantas[@"fromUser"] = currentUser.objectId;
    nyusszantas[@"kind"] = @"👋";
    [nyusszantas saveInBackground];
}

- (void)sendNyusszogas
{
    //find all users other than currentUser
    PFQuery *userQuery = [PFUser query];
    PFUser *currentUser = [PFUser currentUser];
    [userQuery whereKey:@"username" notEqualTo:currentUser.username];
    
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFUser *user in objects) {
            PFPush *push = [[PFPush alloc] init];
            PFQuery *pushUserQuery = [PFInstallation query];
            [pushUserQuery whereKey:@"user" equalTo:user];
            
            [push setQuery:pushUserQuery];
            NSString *msg = [NSString stringWithFormat:@"Megnyusszogtatott! 💋"];
            [push setData:@{@"sound":@"default", @"badge":@"increment",@"alert":msg}];
            [push sendPushInBackground];
            
            NSLog(@"Push sent to %@",user.username);
        }
    }];
    
    PFObject *nyusszantas = [PFObject objectWithClassName:@"History"];
    nyusszantas[@"fromUser"] = currentUser.objectId;
    nyusszantas[@"kind"] = @"💋";
    [nyusszantas saveInBackground];
}

- (void)updateCurrentInstallationWithUser
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    if ([PFUser currentUser] != nil) {
        currentInstallation[@"user"] = [PFUser currentUser];
    }
    [currentInstallation saveInBackground];
}

#pragma mark - LogInView Delegate
- (void)logInViewController:(PFLogInViewController *)controller didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setUpAfterUserLogInOut];
    [self updateCurrentInstallationWithUser];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self setUpAfterUserLogInOut];
}

#pragma mark - SignUpView Delegate
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setUpAfterUserLogInOut];
    [self updateCurrentInstallationWithUser];
}

- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    [self setUpAfterUserLogInOut];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex //0: cancel, 1: yes (sign out)
{
    if (buttonIndex == 0) {
        NSLog(@"user cancelled sign out");
    } else if (buttonIndex == 1) {
        NSLog(@"user signed out, button index %ld", (long)buttonIndex);
        [PFUser logOut];
        [self setUpAfterUserLogInOut];
    }
}

@end

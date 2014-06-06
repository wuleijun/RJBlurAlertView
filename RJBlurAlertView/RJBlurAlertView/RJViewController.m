//
//  RJViewController.m
//  RJBlurAlertView
//
//  Created by jun on 14-6-5.
//  Copyright (c) 2014年 rayjune Wu. All rights reserved.
//

#import "RJViewController.h"
#import "RJBlurAlertView.h"

@interface RJViewController ()

@end

@implementation RJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showAlertViewTouch:(UIButton *)sender {
    RJBlurAlertView *alertView = [[RJBlurAlertView alloc] initWithTitle:@"title" text:@"this is text" cancelButton:YES color:[UIColor blueColor]];
    if (sender.tag == 1) {
        alertView.animationType = RJBlurAlertViewAnimationTypeDrop;
    }
    [alertView setCompletionBlock:^(RJBlurAlertView *alert, UIButton *button) {
        if (button == alert.okButton) {
            NSLog(@"ok button touched!");
        }else{
            NSLog(@"cancel button touched!");
        }
    }];
    [alertView show];
    
//    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 180)];
//    contentView.backgroundColor = [UIColor blackColor];
//    RJBlurAlertView *alertView = [[RJBlurAlertView alloc] initWithTitle:@"title" contentView:contentView cancelButton:YES color:[UIColor blueColor]];
//    [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

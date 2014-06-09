RJBlurAlertView
===============

RJBlurAlertView is a custom alert view with a blurred background view.It can be showed as dropping or bounce.



#How to install
##Cocoapods:

CocoaPods is the recommended way to add RJBlurAlertView to your project.
Add a pod entry for RJBlurAlertView to your Podfile pod 'RJBlurAlertView', '~> 0.0.1'
Install the pod(s) by running pod install.
Include PNChart wherever you need it with #import "RJBlurAlertView.h".

###Old way:
**Copy the `RJBlurAlertView.h` and `RJBlurAlertView.m` to your project**
**Ensure that you have added `GPUImage.framework` in your project.**


#####How To Use
RJBlurAlertView has `RJBlurAlertViewTypeText` and `RJBlurAlertViewTypeCustomView` types.You can use it following ways:

Title and Text:
--------------
	RJBlurAlertView *alertView = [[RJBlurAlertView alloc] initWithTitle:@"title" text:@"this is text" cancelButton:YES color:[UIColor blueColor]];
    
    //set animation type
    alertView.animationType = RJBlurAlertViewAnimationTypeDrop;
    
    [alertView setCompletionBlock:^(RJBlurAlertView *alert, UIButton *button) {
        if (button == alert.okButton) {
            NSLog(@"ok button touched!");
        }else{
            NSLog(@"cancel button touched!");
        }
    }];
    [alertView show];
    
Custom content view:
-------------------

	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 180)]; 
	contentView.backgroundColor = [UIColor blackColor];
    RJBlurAlertView *alertView = [[RJBlurAlertView alloc] initWithTitle:@"title" contentView:contentView cancelButton:YES color:[UIColor blueColor]];
    [alertView show];


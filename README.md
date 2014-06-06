RJBlurAlertView
===============

RJBlurAlertView is a custom alert view with a blurred background view.It can be showed as dropping or bounce.


#How To Use
**Ensure that you have added `GPUImage.framework` in your project.**

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


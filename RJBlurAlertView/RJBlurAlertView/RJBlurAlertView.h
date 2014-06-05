//
//  RJAlertView.h
//  RJAlertView
//
//  Created by jun on 14-6-4.
//  Copyright (c) 2014年 rayjune Wu. All rights reserved.
//
@class RJBlurAlertView;
typedef NS_ENUM(NSInteger, RJBlurAlertViewAnimationType){
    RJBlurAlertViewAnimationTypeBounce,
    RJBlurAlertViewAnimationTypeDrop
};

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>

@interface RJBlurAlertView : UIView
@property (nonatomic,strong) UIButton *okButton;
@property (nonatomic,strong) UIButton *cancelButton;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) UIColor *titleLabelBackgroundColor;
@property(assign) RJBlurAlertViewAnimationType animationType;
@property(nonatomic,copy) void(^completionBlock)(RJBlurAlertView *alertView,UIButton *button);

- (id)initWithTitle:(NSString *)title text:(NSString *)text cancelButton:(BOOL)hasCancelButton color:(UIColor*) color;
- (void)show;
@end

//
//  RJAlertView.h
//  RJAlertView
//
//  Created by jun on 14-6-4.
//  Copyright (c) 2014年 rayjune Wu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>
@class RJBlurAlertView;
@protocol RJBlurAlertViewDelegate;

typedef NS_ENUM(NSInteger, RJBlurAlertViewAnimationType){
    RJBlurAlertViewAnimationTypeBounce,
    RJBlurAlertViewAnimationTypeDrop
};

typedef NS_ENUM(NSInteger, RJBlurAlertViewContentType){
    RJBlurAlertViewContentTypeText,
    RJBlurAlertViewContentTypeCustomView
};

@interface RJBlurAlertView : UIView

@property (nonatomic,strong) UIButton *okButton;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,assign) RJBlurAlertViewAnimationType animationType;
@property (nonatomic,weak) id<RJBlurAlertViewDelegate> delegate;

@property(nonatomic,copy) void(^completionBlock)(RJBlurAlertView *alertView,UIButton *button);

- (id)initWithTitle:(NSString *)title text:(NSString *)text cancelButton:(BOOL)hasCancelButton;
- (id)initWithTitle:(NSString *)title contentView:(UIView *)contentView cancelButton:(BOOL)hasCancelButton;
- (void)show;
- (void)dismiss;

@end

@protocol RJBlurAlertViewDelegate <NSObject>

@optional
-(void) alertView:(RJBlurAlertView *)alertView didDismissWithButton:(UIButton *)button;
-(void) alertViewWillShow:(RJBlurAlertView *)alertView;
-(void) alertViewDidShow:(RJBlurAlertView *)alertView;
-(void) alertViewWillDismiss:(RJBlurAlertView *)alertView;
-(void) alertViewDidDismiss:(RJBlurAlertView *)alertView;

@end

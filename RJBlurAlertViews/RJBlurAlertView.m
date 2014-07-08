//
//  RJAlertView.m
//  RJAlertView
//
//  Created by jun on 14-6-4.
//  Copyright (c) 2014年 rayjune Wu. All rights reserved.
//
static const CGFloat RJAlertViewTitleLabelHeight = 44.0;
static const CGFloat RJAlertViewSpaceHeight = 10;
static const CGFloat RJAlertViewDefaultTextFontSize = 16;

/*Default Colors*/
#define RJTitleLabelBackgroundColor [UIColor colorWithRed:0.20392156862745098 green:0.596078431372549 blue:0.8588235294117647 alpha:1.0]
#define RJComfirmButtonColor [UIColor colorWithRed:0.20392156862745098 green:0.596078431372549 blue:0.8588235294117647 alpha:1.0]

#define screenBounds [[UIScreen mainScreen] bounds]
#define IS_IOS7_Or_Later [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#import "RJBlurAlertView.h"
#import "UIImage+ImageEffects.h"

@interface RJBlurAlertView ()

//@property (nonatomic,strong) GPUImageiOSBlurFilter *blurFilter;
@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UIImageView *backgroundView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,assign) CGSize contentSize;
@property (nonatomic,assign) RJBlurAlertViewContentType contentType;
@property (nonatomic,strong) UIView *contentView;
@end

@implementation RJBlurAlertView

- (id)initWithTitle:(NSString *)title contentView:(UIView *)contentView cancelButton:(BOOL)hasCancelButton
{
    self = [super initWithFrame:screenBounds];
    if (self) {
        self.opaque = YES;
        self.alpha = 1;
        _contentType = RJBlurAlertViewContentTypeCustomView;
        _contentView = contentView;
        [self _setupViewsWithTitle:title text:nil cancelButton:hasCancelButton];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title text:(NSString *)text cancelButton:(BOOL)hasCancelButton
{
    self = [super initWithFrame:screenBounds];
    if (self) {
        self.opaque = YES;
        self.alpha = 1;
        _contentType = RJBlurAlertViewContentTypeText;
        [self _setupViewsWithTitle:title text:text cancelButton:hasCancelButton];
    }
    return self;
}

#pragma mark - Show and Dismiss
- (void)show
{
    if ([self.delegate respondsToSelector:@selector(alertViewWillShow:)]) {
        [self.delegate alertViewWillShow:self];
    }
    
    switch (self.animationType) {
        case RJBlurAlertViewAnimationTypeBounce:
            [self triggerBounceAnimations];
            break;
        case RJBlurAlertViewAnimationTypeDrop:
            [self triggerDropAnimations];
            break;
        default:
            break;
    }
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if (!window){
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    [window addSubview:self];
}

- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(alertViewWillDismiss:)]) {
        [self.delegate alertViewWillDismiss:self];
    }
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         if ([self.delegate respondsToSelector:@selector(alertViewDidDismiss:)]){
                             [self.delegate alertViewDidDismiss:self];
                         }
                     }];
}

#pragma mark - Animations
- (void) triggerBounceAnimations
{
    
    self.alertView.alpha = 0;
    self.alertView.center = CGPointMake(CGRectGetWidth(screenBounds)/2, (CGRectGetHeight(screenBounds)/2));
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3f;
    //animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.alertView.layer addAnimation:animation forKey:nil];
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.backgroundView setAlpha:1.0];
                         [self.alertView setAlpha:1.0];
                     }
                     completion:^(BOOL finished){
                         if ([self.delegate respondsToSelector:@selector(alertViewDidShow:)]) {
                             [self.delegate alertViewDidShow:self];
                         }
                     }];
}

-(void) triggerDropAnimations
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.4f;
    //animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(screenBounds.size.width/2, -self.alertView.frame.size.height)]];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(screenBounds.size.width/2, (screenBounds.size.height/2)+self.alertView.frame.size.height*0.05)]];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(screenBounds.size.width/2, (screenBounds.size.height/2))]];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(screenBounds.size.width/2, (screenBounds.size.height/2)-self.alertView.frame.size.height*0.05)]];
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(screenBounds.size.width/2, (screenBounds.size.height/2))]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.alertView.layer addAnimation:animation forKey:nil];
    

    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.backgroundView.alpha = 1.0;
    } completion:^(BOOL finished){
        if ([self.delegate respondsToSelector:@selector(alertViewDidShow:)]) {
            [self.delegate alertViewDidShow:self];
        }
    }];

}

#pragma mark - View Setup
- (void)_setupViewsWithTitle:(NSString *)title text:(NSString *)aText cancelButton:(BOOL)hasCancelButton
{
    
    [self calculateContentSize:aText];
    
    _backgroundView = [[UIImageView alloc]initWithFrame:screenBounds];
    UIImage * image = [self _convertViewToImage];
    UIImage *blurredSnapshotImage = [image applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:1.0 alpha:0.3] saturationDeltaFactor:1.8 maskImage:nil];
    [self.backgroundView setImage:blurredSnapshotImage];
    self.backgroundView.alpha = 0.0;
    [self addSubview:self.backgroundView];
    
    /*setup alertPopupView*/
    self.alertView = [self _alertPopupView];

    /*setup title and content view*/
    [self _labelSetupWithTitle:title andText:aText];
    [self addSubview:self.alertView];
 
    /*setup buttons*/
    [self _buttonSetupWithCancelButton:hasCancelButton];
}

- (void)_labelSetupWithTitle:(NSString*) title andText:(NSString*) text
{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, RJAlertViewTitleLabelHeight)];
    _titleLabel.center = CGPointMake(CGRectGetWidth(self.alertView.frame)/2, RJAlertViewTitleLabelHeight/2);
    _titleLabel.text = title;
    _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:20.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.alertView addSubview:_titleLabel];
    
    
    if (self.contentType == RJBlurAlertViewContentTypeText) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, self.contentSize.height)];
        _textLabel.center = CGPointMake(self.alertView.frame.size.width/2, CGRectGetHeight(self.alertView.frame)/2);
        _textLabel.text = text;
        _textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:RJAlertViewDefaultTextFontSize];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _textLabel.numberOfLines = 0;
        [self.alertView addSubview:_textLabel];
    }else{
        //customView type
        self.contentView.center = CGPointMake(self.alertView.frame.size.width/2, CGRectGetHeight(self.alertView.frame)/2);
        [self.alertView addSubview:self.contentView];
    }
}

- (UIView*)_alertPopupView
{
    UIView * alertSquare = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, RJAlertViewTitleLabelHeight+2*RJAlertViewSpaceHeight+self.contentSize.height+RJAlertViewTitleLabelHeight)];
    alertSquare.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1];
    alertSquare.center = CGPointMake(CGRectGetWidth(screenBounds)/2, CGRectGetHeight(screenBounds)/2);
    
    [alertSquare.layer setCornerRadius:4.0];
    [alertSquare.layer setShadowColor:[UIColor blackColor].CGColor];
    [alertSquare.layer setShadowOpacity:0.4];
    [alertSquare.layer setShadowRadius:20.0f];
    [alertSquare.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    alertSquare.clipsToBounds = YES;
    
    //add top background view
    UIView *topBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(alertSquare.frame), RJAlertViewTitleLabelHeight)];
    topBackgroundView.backgroundColor = RJTitleLabelBackgroundColor;
    [alertSquare addSubview:topBackgroundView];
    
    return alertSquare;
}

- (void)_buttonSetupWithCancelButton:(BOOL) hasCancelButton
{
    CGFloat buttonCenterY = (CGRectGetHeight(self.alertView.frame)*2-30-RJAlertViewSpaceHeight)/2;
    if (hasCancelButton) {
        //ok button
        _okButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 84, 30)];
        _okButton.center = CGPointMake((CGRectGetWidth(self.alertView.frame)/4)+3, buttonCenterY);
        
        //cancel button
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 84, 30)];
        _cancelButton.center = CGPointMake((CGRectGetWidth(self.alertView.frame)*3/4)-3, buttonCenterY);
        _cancelButton.backgroundColor = [UIColor colorWithRed:0.792 green:0.792 blue:0.792 alpha:1];
        
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.textColor = [UIColor whiteColor];
        _cancelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
		[_cancelButton addTarget:self action:@selector(handleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton.layer setCornerRadius:3.0f];
    }else{
        _okButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _okButton.center = CGPointMake(CGRectGetWidth(self.alertView.frame)/2, buttonCenterY);
    }
    
    [_okButton setBackgroundColor:RJComfirmButtonColor];
    
    //ok button end setup
    [_okButton setTitle:@"确定" forState:UIControlStateNormal];
    _okButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
	[_okButton addTarget:self action:@selector(handleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [_okButton.layer setCornerRadius:3.0f];
    
    [self.alertView addSubview:_okButton];
    if (hasCancelButton){
        [self.alertView addSubview:_cancelButton];
    }
    
}

- (void)calculateContentSize:(NSString *)text
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:RJAlertViewDefaultTextFontSize];
    CGSize constrainedSize = CGSizeMake(180, CGFLOAT_MAX);
    
    if (IS_IOS7_Or_Later)
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        self.contentSize =[text boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.contentSize = [text sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    
    if (self.contentType == RJBlurAlertViewContentTypeCustomView) {
        self.contentSize = self.contentView.bounds.size;
    }
}

-(UIImage *)_convertViewToImage
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedScreen;
}



#pragma mark - Button Action
- (void)handleButtonTouched:(UIButton *)button
{
    [self dismiss];
    
    if ([self.delegate respondsToSelector:@selector(alertView:didDismissWithButton:)]) {
        [self.delegate alertView:self didDismissWithButton:button];
    }
    
    if (self.completionBlock) {
        self.completionBlock(self,button);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

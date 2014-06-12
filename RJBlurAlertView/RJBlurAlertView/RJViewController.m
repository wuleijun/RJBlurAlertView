//
//  RJViewController.m
//  RJBlurAlertView
//
//  Created by jun on 14-6-5.
//  Copyright (c) 2014年 rayjune Wu. All rights reserved.
//
NSString *const RJAlertViewContentTypeKey = @"RJAlertViewContentTypeKey";
NSString *const RJAlertViewContentTypeText = @"RJAlertViewContentTypeText";
NSString *const RJAlertViewContentTypeContent = @"RJAlertViewContentTypeContent";

#import "RJViewController.h"
#import "RJBlurAlertView.h"

@interface RJViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *sections;
@property (nonatomic,strong) NSArray *items;
@end

@implementation RJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageview setImage:[UIImage imageNamed:@"background.jpg"]];
    [self.tableView setBackgroundView:imageview];
    
    self.sections = @[@"AnimationTypeDrop",@"AnimationTypeBounce"];
    self.items = @[@{RJAlertViewContentTypeKey:RJAlertViewContentTypeText},@{RJAlertViewContentTypeKey: RJAlertViewContentTypeContent}];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sections[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	cell.textLabel.text = [self.items[indexPath.row] objectForKey:RJAlertViewContentTypeKey];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    RJBlurAlertView *alertView;
    if ([[self.items[indexPath.row] objectForKey:RJAlertViewContentTypeKey] isEqualToString:RJAlertViewContentTypeContent]) {
        UIImageView *contentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 180)];
        contentView.image = [UIImage imageNamed:@"background.jpg"];
        
        alertView = [[RJBlurAlertView alloc] initWithTitle:@"customview_example" contentView:contentView cancelButton:YES];
    }else{
        alertView = [[RJBlurAlertView alloc] initWithTitle:@"title_example" text:@"this is text" cancelButton:YES];
    }
    
    alertView.animationType = indexPath.section == 0? RJBlurAlertViewAnimationTypeDrop:RJBlurAlertViewAnimationTypeBounce;
    
    [alertView setCompletionBlock:^(RJBlurAlertView *alert, UIButton *button) {
        if (button == alert.okButton) {
            NSLog(@"ok button touched!");
        }else{
            NSLog(@"cancel button touched!");
        }
    }];
    [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

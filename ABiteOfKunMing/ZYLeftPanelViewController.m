//
//  ZYLeftPanelViewController.m
//  ABiteOfKunMing
//
//  Created by zCloud on 14-7-20.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import "ZYLeftPanelViewController.h"
#import "ZYAppDelegate.h"

@interface ZYLeftPanelViewController ()

@end

@implementation ZYLeftPanelViewController

-(ZYAppDelegate *)appDelegate
{
    return (ZYAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (IBAction)logout:(id)sender
{
    [[self appDelegate].wbManager logout];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self appDelegate].wbManager.isAccessTokenValid = NO;
    [[self appDelegate].wbManager checkAuthValid];
}


@end

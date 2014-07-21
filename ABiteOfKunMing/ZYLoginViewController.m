//
//  ZYLoginViewController.m
//  ABiteOfKunMing
//
//  Created by zCloud on 14-7-20.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import "ZYLoginViewController.h"

#define SHOWTABLEVIEW_SEGUE_ID_KEY @"showTableView"

@interface ZYLoginViewController ()<ZYWeiBoManagerDelegate>

@end

@implementation ZYLoginViewController

-(ZYAppDelegate *)appDelegate
{
    return (ZYAppDelegate *)[UIApplication sharedApplication].delegate;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self appDelegate].wbManager.delegate = self;
    [[self appDelegate].wbManager checkAuthValid];
}

#pragma mark - Action

- (IBAction)Login:(id)sender
{
    [[self appDelegate].wbManager loginWithRootViewController:self];
}


#pragma mark - wbManager Delegate

-(void)isAuthValid
{
    if ([self appDelegate].wbManager.isAccessTokenValid == NO) {
        _lunchImageLayout.hidden = YES;
    }else if([self appDelegate].wbManager.isAccessTokenValid == YES){
        [self performSegueWithIdentifier:SHOWTABLEVIEW_SEGUE_ID_KEY sender:self];
    }
}

@end

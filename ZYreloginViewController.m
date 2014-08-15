//
//  ZYreloginViewController.m
//  ABiteOfKunMing
//
//  Created by zCloud on 14-8-1.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import "ZYreloginViewController.h"

#define SHOWTABLEVIEW_SEGUE_ID_KEY @"showTableView"

@interface ZYreloginViewController ()

<ZYWeiBoManagerDelegate>


@end

@implementation ZYreloginViewController

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
        //_lunchImageLayout.hidden = YES;
    }else if([self appDelegate].wbManager.isAccessTokenValid == YES){
        [self performSegueWithIdentifier:SHOWTABLEVIEW_SEGUE_ID_KEY sender:self];
        [self appDelegate].wbManager.loginFlag = NO;
        [self appDelegate].wbManager.reLoginFlag = YES;
    }
}


@end

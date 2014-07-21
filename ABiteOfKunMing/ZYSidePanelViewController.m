//
//  ZYSidePanelViewController.m
//  ABiteOfKunMing
//
//  Created by zCloud on 14-7-20.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import "ZYSidePanelViewController.h"

#define SHOWLOGINVIEW_SEGUE_KEY @"showLoginView"

@interface ZYSidePanelViewController ()

@end

@implementation ZYSidePanelViewController

-(void)awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"centerViewController"]];
    
}



@end

//
//  ZYAppDelegate.h
//  ABiteOfKunMing
//
//  Created by zCloud on 14-7-18.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYWeiBoManager.h"
#import "ZYCheckAuth.h"
#import "BMapKit.h"
#import "JASidePanelController.h"

@interface ZYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ZYWeiBoManager *wbManager;
@property (strong, nonatomic) ZYCheckAuth *checkAuth;
@property (strong, nonatomic) JASidePanelController *viewController;

@end

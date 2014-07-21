//
//  ZYWeiBoManager.h
//  ABiteOfKunMing
//
//  Created by zCloud on 14-7-20.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboApi.h"

@protocol ZYWeiBoManagerDelegate <NSObject>

-(void)isAuthValid;

@end

@interface ZYWeiBoManager : NSObject

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *openId;
@property (strong, nonatomic) NSString *appKey;
@property (strong, nonatomic) NSString *appSecrect;
@property BOOL isAccessTokenValid;

@property (weak) id <ZYWeiBoManagerDelegate> delegate;

-(BOOL)handleOpenURL:(NSURL *) url;
-(void)checkAuthValid;
-(void)loginWithRootViewController:(UIViewController *)rootCtrl;
-(void)logout;

@end

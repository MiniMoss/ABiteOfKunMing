//
//  ZYCheckAuth.h
//  ABiteOfKunMing
//
//  Created by zCloud on 14-8-4.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboApi.h"

@protocol ZYCheckAuthDelegate <NSObject>

- (void)isAuthValid;

@end

@interface ZYCheckAuth : NSObject

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *openId;
@property (strong, nonatomic) NSString *appKey;
@property (strong, nonatomic) NSString *appSecrect;
@property BOOL isAccessTokenValid;


@property (weak) id <ZYCheckAuthDelegate> delegate;

- (void)checkAuthValid;

@end

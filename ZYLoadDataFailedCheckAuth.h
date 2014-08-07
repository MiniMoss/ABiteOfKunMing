//
//  ZYLoadDataFailedCheckAuth.h
//  ABiteOfKunMing
//
//  Created by zCloud on 14-8-7.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboApi.h"


@protocol ZYLoadDataFailedCheckAuth <NSObject>

- (void)isAuthValid;

@end

@interface ZYLoadDataFailedCheckAuth : NSObject

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *openId;
@property (strong, nonatomic) NSString *appKey;
@property (strong, nonatomic) NSString *appSecrect;



@property (weak) id <ZYLoadDataFailedCheckAuth> delegate;

- (void)checkAuthValid;
-(void)logout;
@end


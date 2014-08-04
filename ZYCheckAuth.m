//
//  ZYCheckAuth.m
//  ABiteOfKunMing
//
//  Created by zCloud on 14-8-4.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import "ZYCheckAuth.h"

#define APPKEY @"801515859"
#define APPSECRECT @"34ec44459431ebe4020974cb655f87b3"
#define REDIRECTURI @"http://www.baidu.com"

@interface ZYCheckAuth () <WeiboRequestDelegate,WeiboAuthDelegate>

@property (strong, nonatomic) WeiboApi *wbapi;

@end

@implementation ZYCheckAuth

- (WeiboApi *)wbapi
{
    if (!_wbapi) {
        _wbapi = [[WeiboApi alloc]initWithAppKey:APPKEY
                                       andSecret:APPSECRECT
                                  andRedirectUri:REDIRECTURI
                                 andAuthModeFlag:TCWBModelDefault
                                  andCachePolicy:TCWBCachePolicyCacheFirst];
    }
    return _wbapi;
}

#pragma mark - Public methods

-(void)checkAuthValid
{
    [self.wbapi checkAuthValid:TCWBAuthCheckServer andDelegete:self];
}

#pragma mark - WeiboAuthDelegate

/**
 * @brief   授权成功后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
-(void)didCheckAuthValid:(BOOL)bResult suggest:(NSString *)strSuggestion
{
    NSString *str = [[NSString alloc] initWithFormat:@"ret=%d, suggestion = %@", bResult, strSuggestion];
    NSLog(@"%@",str);
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        _isAccessTokenValid = bResult;
        _accessToken = [self.wbapi getToken].accessToken;
        _openId = [self.wbapi getToken].openid;
        _appKey = [self.wbapi getToken].appKey;
        _appSecrect = [self.wbapi getToken].appSecret;
        
        [self.delegate isAuthValid];
    });
    
}

@end

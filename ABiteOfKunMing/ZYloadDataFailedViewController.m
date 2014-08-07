//
//  ZYloadDataFailedViewController.m
//  ABiteOfKunMing
//
//  Created by zCloud on 14-8-7.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import "ZYloadDataFailedViewController.h"
#import "AFNetworking.h"


#define BASE_URL_KEY @"http://open.t.qq.com/api/statuses/user_timeline?format=json&pageflag=0&pagetime=0&reqnum=5&lastid=0&name=zCloud1984&fopenid=&type=0&contenttype=0&clientip=&oauth_version=2.a&scope=all&oauth_consumer_key=%@&access_token=%@&openid=%@"

@interface ZYloadDataFailedViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lable;


@end

@implementation ZYloadDataFailedViewController

- (ZYAppDelegate *)appDelegate
{
    return (ZYAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}


- (IBAction)refresh:(id)sender {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                break;
            case  AFNetworkReachabilityStatusUnknown:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [self dismissViewControllerAnimated:YES completion:nil];
                [self appDelegate].wbManager.reLoginFlag = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [self dismissViewControllerAnimated:YES completion:nil];
                [self appDelegate].wbManager.reLoginFlag =YES;
                break;
            default:
                break;
        }
    }];
}



@end

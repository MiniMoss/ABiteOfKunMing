//
//  ZYCheckBaiDuZhiDaoViewController.m
//  ABiteOfKunMing
//
//  Created by zCloud on 8/18/14.
//  Copyright (c) 2014 Yun.Zou. All rights reserved.
//

#import "ZYCheckBaiDuZhiDaoViewController.h"



@interface ZYCheckBaiDuZhiDaoViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *baiDuZhiDaoWebView;

@end

@implementation ZYCheckBaiDuZhiDaoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *str = [@"http:" stringByAppendingString:_baiDuZhiDaoUrl];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.baiDuZhiDaoWebView loadRequest:urlRequest];
    
}





@end

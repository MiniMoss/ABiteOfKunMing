//
//  ZYAddAndInfoTableViewController.h
//  ABiteOfKunMing
//
//  Created by zCloud on 14-8-10.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYAddAndInfoTableViewController : UITableViewController

@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *baiDuZhiDaoUrl;
@property (weak, nonatomic) IBOutlet UILabel *lableAddress;


@end

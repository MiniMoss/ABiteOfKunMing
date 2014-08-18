//
//  ZYCellDetailViewController.h
//  ABiteOfKunMing
//
//  Created by zCloud on 14-7-20.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZYCellDetailViewController : UIViewController

@property (strong, nonatomic) NSString *selectedLat;
@property (strong, nonatomic) NSString *selectedLon;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *baiDuZhiDaoUrl;
@property (strong, nonatomic) NSMutableArray *detailImageUrlArr;

@end

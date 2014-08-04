//
//  ZYCellDetailViewController.m
//  ABiteOfKunMing
//
//  Created by zCloud on 14-7-20.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import "ZYCellDetailViewController.h"
#import "ZYBDMapViewController.h"
#import "ZYImageCollectionViewController.h"
#import "ZYAppDelegate.h"

#define SHOWMAP_SEGUE_ID_KEY @"showMap"
#define SHOWDETAILIMAGE_SEGUE_ID_KEY @"showDetailImage"

@interface ZYCellDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *lablePlace;

@end

@implementation ZYCellDetailViewController

-(ZYAppDelegate *)appDelegate
{
    return (ZYAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = _name;
    self.lablePlace.text = _place;
    [self appDelegate].wbManager.loginFlag = NO;
    [self appDelegate].wbManager.reLoginFlag = NO;
}


#pragma mark - Action

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SHOWMAP_SEGUE_ID_KEY]) {
        ZYBDMapViewController *BDMapViewController = segue.destinationViewController;
        BDMapViewController.pinLat = _selectedLat;
        BDMapViewController.pinLon = _selectedLon;
        BDMapViewController.name = _name;
    }else if ([segue.identifier isEqualToString:SHOWDETAILIMAGE_SEGUE_ID_KEY]){
        ZYImageCollectionViewController *DetailImageViewController = segue.destinationViewController;
        DetailImageViewController.detailImageUrlArr = _detailImageUrlArr;
    }
}

@end

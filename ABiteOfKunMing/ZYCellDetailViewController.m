//
//  ZYCellDetailViewController.m
//  ABiteOfKunMing
//
//  Created by zCloud on 14-7-20.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import "ZYCellDetailViewController.h"
#import "ZYBDMapViewController.h"

#define SHOWMAP_SEGUE_ID_KEY @"showMap"

@interface ZYCellDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *lableLat;
@property (strong, nonatomic) IBOutlet UILabel *lableLon;


@end

@implementation ZYCellDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.lableLat.text = _selectedLat;
    self.lableLon.text = _selectedLon;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - Action

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SHOWMAP_SEGUE_ID_KEY]) {
        ZYBDMapViewController *BDMapViewController = segue.destinationViewController;
        BDMapViewController.pinLat = _selectedLat;
        BDMapViewController.pinLon = _selectedLon;
    }
}

@end

//
//  ZYAddAndInfoTableViewController.m
//  ABiteOfKunMing
//
//  Created by zCloud on 14-8-10.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import "ZYAddAndInfoTableViewController.h"
#import "ZYCheckBaiDuZhiDaoViewController.h"
#define CHECHBAIDUZHIDAO_SEGUE_ID_KEY @"checkBaiDuZhiDao"

@interface ZYAddAndInfoTableViewController ()

@end

@implementation ZYAddAndInfoTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _lableAddress.text = _address;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:CHECHBAIDUZHIDAO_SEGUE_ID_KEY sender:self];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   if ([segue.identifier isEqualToString:CHECHBAIDUZHIDAO_SEGUE_ID_KEY]){
        ZYCheckBaiDuZhiDaoViewController *checkBaiDuZhiDao = (ZYCheckBaiDuZhiDaoViewController *)segue.destinationViewController;
        checkBaiDuZhiDao.baiDuZhiDaoUrl = _baiDuZhiDaoUrl;
    }
}


//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return 2;
//}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ZYCenterPanelViewController.m
//  ABiteOfKunMing
//
//  Created by zCloud on 14-7-20.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import "ZYCenterPanelViewController.h"
#import "ZYCellDetailViewController.h"

#define BASE_URL_KEY @"http://open.t.qq.com/api/statuses/user_timeline?format=json&pageflag=0&pagetime=0&reqnum=5&lastid=0&name=zCloud1984&fopenid=&type=0&contenttype=0&clientip=&oauth_version=2.a&scope=all&oauth_consumer_key=%@&access_token=%@&openid=%@"

#define TIMESTAMP_URL_KEY @"http://open.t.qq.com/api/statuses/user_timeline?format=json&pageflag=1&pagetime=%@&reqnum=5&lastid=0&name=zCloud1984&fopenid=&type=0&contenttype=0&clientip=&oauth_version=2.a&scope=all&oauth_consumer_key=%@&access_token=%@&openid=%@"

//test URL 改name
#define TEST_BASE_URL_KEY @"http://open.t.qq.com/api/statuses/user_timeline?format=json&pageflag=0&pagetime=0&reqnum=10&lastid=0&name=hua19761110&fopenid=&type=0&contenttype=0&clientip=&oauth_version=2.a&scope=all&oauth_consumer_key=%@&access_token=%@&openid=%@"

#define TEST_TIMESTAMP_URL_KEY @"http://open.t.qq.com/api/statuses/user_timeline?format=json&pageflag=1&pagetime=%@&reqnum=10&lastid=0&name=hua19761110&fopenid=&type=0&contenttype=0&clientip=&oauth_version=2.a&scope=all&oauth_consumer_key=%@&access_token=%@&openid=%@"

@interface ZYCenterPanelViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSString *selectedLat;
@property (strong, nonatomic) NSString *selectedLon;
@property (weak, nonatomic) IBOutlet UITableView *WBDataTableView;

@end

@implementation ZYCenterPanelViewController

-(ZYAppDelegate *)appDelegate
{
    return (ZYAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    _dataSource = [[NSMutableArray alloc] init];
    
    self.WBDataTableView.delegate = self;
    self.WBDataTableView.dataSource = self;
    
    // setup pull-to-refresh
    [_WBDataTableView addPullToRefreshWithActionHandler:^{
        [self insertRowAtTop];
    }];
    
    // setup infinite scrolling
    [_WBDataTableView addInfiniteScrollingWithActionHandler:^{
        [self insertRowAtBottom];
    }];
    
    //test URL
    NSString *urlStr = [NSString stringWithFormat:TEST_BASE_URL_KEY,[self appDelegate].wbManager.appKey, [self appDelegate].wbManager.accessToken, [self appDelegate].wbManager.openId];
    //NSString *urlStr = [NSString stringWithFormat:BASE_URL_KEY,[self appDelegate].wbManager.appKey, [self appDelegate].wbManager.accessToken, [self appDelegate].wbManager.openId];
    //NSLog(@"%@",urlStr);
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id json) {
        NSDictionary *dicJson=[[NSDictionary alloc]initWithDictionary:json];
        NSDictionary *dicData = [dicJson objectForKey:@"data"];
        NSArray *arrInfo = [dicData objectForKey:@"info"];
        for (int i = 0; i < [arrInfo count]; i++) {
            [_dataSource addObject:arrInfo[i]];
        }
        [self.WBDataTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
    [operation start];
    
}


#pragma mark - Actions

- (IBAction)showLeft:(id)sender
{
    [self.sidePanelController showLeftPanelAnimated:YES];
}


- (void)insertRowAtTop
{
    //test URL
    NSString *urlStr = [NSString stringWithFormat:TEST_BASE_URL_KEY,[self appDelegate].wbManager.appKey, [self appDelegate].wbManager.accessToken, [self appDelegate].wbManager.openId];
    //NSString *urlStr = [NSString stringWithFormat:BASE_URL_KEY,[self appDelegate].wbManager.appKey, [self appDelegate].wbManager.accessToken, [self appDelegate].wbManager.openId];
    //NSLog(@"%@",urlStr);
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id json) {
        NSDictionary *dicJson=[[NSDictionary alloc]initWithDictionary:json];
        NSDictionary *dicData = [dicJson objectForKey:@"data"];
        NSArray *arrInfo = [dicData objectForKey:@"info"];
        [_dataSource removeAllObjects];
        for (int i = 0; i < [arrInfo count]; i++) {
            [_dataSource addObject:arrInfo[i]];
        }
        [self.WBDataTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
    [operation start];
    [_WBDataTableView.pullToRefreshView stopAnimating];
    
}


- (void)insertRowAtBottom
{
    //pageflag = 1 结合pagetime = last timestamp向下翻页更新微博
    NSString *timeStamp = [NSString stringWithFormat:@"%@", [[_dataSource objectAtIndex:[_dataSource count] - 1] objectForKey:@"timestamp"]];
    
    //test URL
    NSString *urlStr = [NSString stringWithFormat:TEST_TIMESTAMP_URL_KEY,timeStamp,[self appDelegate].wbManager.appKey, [self appDelegate].wbManager.accessToken, [self appDelegate].wbManager.openId];
    
    //NSString *urlStr = [NSString stringWithFormat:TIMESTAMP_URL_KEY,timeStamp,[self appDelegate].wbManager.appKey, [self appDelegate].wbManager.accessToken, [self appDelegate].wbManager.openId];
    //NSLog(@"%@",urlStr);
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id json) {
        NSDictionary *dicJson=[[NSDictionary alloc]initWithDictionary:json];
        NSDictionary *dicData = [dicJson objectForKey:@"data"];
        //判断是否返回到达最后一条微博，防止溢出
        NSString *checkData = [dicJson objectForKey:@"msg"];
        if ([checkData isEqualToString:@"ok"]) {
            NSArray *arrInfo = [dicData objectForKey:@"info"];
            for (int i = 0; i < [arrInfo count]; i++) {
                [_dataSource addObject:arrInfo[i]];
            }
            [self.WBDataTableView reloadData];
        }else if([checkData isEqualToString:@"have no tweet"]){
            [_WBDataTableView.infiniteScrollingView stopAnimating];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
    [operation start];
    [_WBDataTableView.infiniteScrollingView stopAnimating];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showCellDetail"]) {
        ZYCellDetailViewController *cellDetailViewController = segue.destinationViewController;
        cellDetailViewController.selectedLat = _selectedLat;
        cellDetailViewController.selectedLon = _selectedLon;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_dataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WBDataCell";
    ZYCellOfCenterPanelTableView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    // Configure the cell...
    __weak ZYCellOfCenterPanelTableView *weakCell = cell;
    NSArray *imageUrlArray = [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"image"];
    if (![imageUrlArray isKindOfClass:[NSNull class]]) {
        NSString *strImageUrl = [[imageUrlArray objectAtIndex:0] stringByAppendingString:@"/auto"];
        NSURL *imageUrl = [NSURL URLWithString: strImageUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
        [cell.imageView setImageWithURLRequest:request
                              placeholderImage:[UIImage imageNamed:@"placeHolder"]
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           weakCell.cellImage.image = image;
                                       } failure:nil];

    }else{
        weakCell.cellImage.image = nil;
    }
    
    cell.labelTitle.text = [NSString stringWithFormat:@"%@", [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"origtext"]];
    cell.labelSubtitle.text = [NSString stringWithFormat:@"%@", [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"longitude"]];
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    _selectedLat = [NSString stringWithFormat:@"%@", [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"latitude"]];
    _selectedLon = [NSString stringWithFormat:@"%@", [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"longitude"]];
    [self performSegueWithIdentifier:@"showCellDetail" sender:self];
}

@end

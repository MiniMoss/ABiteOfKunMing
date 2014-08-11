//
//  ZYImageCollectionViewController.m
//  ABiteOfKunMing
//
//  Created by zCloud on 14-8-4.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import "ZYImageCollectionViewController.h"
#import "ZYImageCollectionViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface ZYImageCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@end

@implementation ZYImageCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _imageCollectionView.delegate = self;
    _imageCollectionView.dataSource = self;
    
}

#pragma mark - Methods

- (void)loadCellImage:(ZYImageCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    __weak ZYImageCollectionViewCell *weakCell = cell;
    if (![_detailImageUrlArr isKindOfClass:[NSNull class]]) {
        NSString *strImageUrl = [[_detailImageUrlArr objectAtIndex:indexPath.row] stringByAppendingString:@"/auto"];
        NSURL *imageUrl = [NSURL URLWithString: strImageUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
        [cell.cellImage setImageWithURLRequest:request
                              placeholderImage:[UIImage imageNamed:@"placeHolder"]
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           weakCell.cellImage.image = image;
                                           //weakCell.cellImage.contentMode = UIViewContentModeCenter;
                                           weakCell.cellImage.contentMode =UIViewContentModeScaleAspectFit;
                                       } failure:nil];
    }else{
        weakCell.cellImage.image = nil;
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_detailImageUrlArr count];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   ZYImageCollectionViewCell *cell = (ZYImageCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell"
                                                                                                              forIndexPath:indexPath];
    [self loadCellImage:cell indexPath:indexPath];
    return cell;
}

@end

//
//  ZYBDMapViewController.m
//  ABiteOfKunMing
//
//  Created by zCloud on 14-7-18.
//  Copyright (c) 2014年 Yun.Zou. All rights reserved.
//

#import "ZYBDMapViewController.h"
#import "BMapKit.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#define APLLEMAP_URL_KEY @"http://maps.apple.com/maps?saddr=%f,%f&daddr=%f,%f"
#define GOOGLEMAP_URL_KEY @"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f"


@interface ZYBDMapViewController ()<BMKMapViewDelegate,CLLocationManagerDelegate,BMKLocationServiceDelegate,UIActionSheetDelegate>
{
    IBOutlet BMKMapView *mapView;
}

@property (nonatomic, strong) BMKLocationService *locService;
@property CLLocationCoordinate2D startCoor;
@property CLLocationCoordinate2D endCoor;

//- (void)appleNav;

@end

@implementation ZYBDMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    self.view = mapView;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [mapView viewWillAppear];
    mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    // 添加一个PointAnnotation
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    //TC微博获取的坐标，有偏移
    CLLocationCoordinate2D coor;
    coor.latitude = [_pinLat doubleValue];
    coor.longitude = [_pinLon doubleValue];
    //坐标转换,纠正偏移
    NSDictionary *dicFixLocation = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_COMMON);
    CLLocationCoordinate2D fixedLocationCoor = BMKCoorDictionaryDecode(dicFixLocation);
    annotation.coordinate = fixedLocationCoor;
    //导航终点坐标
    _endCoor = fixedLocationCoor;
    
    annotation.title = _name ;
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMakeWithDistance(annotation.coordinate, 1500, 1500);
    [mapView setRegion:viewRegion animated:YES];
    [mapView addAnnotation:annotation];
    [mapView selectAnnotation:annotation animated:YES]; 
}

- (void)viewWillDisappear:(BOOL)animated
{
    [mapView viewWillDisappear];
    mapView.delegate = nil; // 不用时，置nil
}

#pragma mark - Methods

- (IBAction)showActionSheet:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择导航"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"百度地图客户端导航",@"百度地图网页导航",@"苹果地图导航",nil];
    [actionSheet showInView:self.view];
}

//调启百度地图客户端导航
- (IBAction)nativeNavi
{
    //初始化调启导航时的参数管理类
    BMKNaviPara* para = [[BMKNaviPara alloc]init];
    //指定导航类型
    para.naviType = BMK_NAVI_TYPE_NATIVE;
    
    //初始化终点节点
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    //指定终点经纬度
    CLLocationCoordinate2D coor2;
    coor2.latitude = _endCoor.latitude;
    coor2.longitude = _endCoor.longitude;
    end.pt = coor2;
    //指定终点名称
    //end.name = _nativeEndName.text;
    //指定终点
    para.endPoint = end;
    
    //指定返回自定义scheme，具体定义方法请参考常见问题
    para.appScheme = @"baidumapsdk://mapsdk.baidu.com";
    //调启百度地图客户端导航
    [BMKNavigation openBaiduMapNavigation:para];
    
}

//调启web导航
- (IBAction)webNavi
{
    //初始化调启导航时的参数管理类
    BMKNaviPara *para = [[BMKNaviPara alloc]init];
    //指定导航类型
    para.naviType = BMK_NAVI_TYPE_WEB;
    
    //初始化起点节点
    BMKPlanNode *start = [[BMKPlanNode alloc]init];
    //指定起点经纬度
    CLLocationCoordinate2D coor1;
    coor1.latitude = _startCoor.latitude;
    coor1.longitude = _startCoor.longitude;
    start.pt = coor1;
    //指定起点名称
    //start.name = _webStartName.text;
    //指定起点
    para.startPoint = start;
    
    
    //初始化终点节点
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    CLLocationCoordinate2D coor2;
    coor2.latitude = _endCoor.latitude;
    coor2.longitude = _endCoor.longitude;
    end.pt = coor2;
    para.endPoint = end;
    //指定终点名称
    //end.name = _webEndName.text;
    //指定调启导航的app名称
    para.appName = [NSString stringWithFormat:@"%@", @"testAppName"];
    //调启web导航
    [BMKNavigation openBaiduMapNavigation:para];
}

- (void)appleNav
{
    CLLocationCoordinate2D endCoor;
    endCoor.latitude = _endCoor.latitude;
    endCoor.longitude = _endCoor.longitude;

    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:placemark];
    toLocation.name = _name;
    
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}

#pragma mark - ActionSheet delegate

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self nativeNavi];
            break;
        case 1:
            [self webNavi];
            break;
        case 2:
            [self appleNav];
            break;
        default:
            break;
    }
}

/*
 - (void)actionSheetCancel:(UIActionSheet *)actionSheet
 {
 //
 }
 
 -(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
 {
 //
 }
 
 -(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
 {
 //
 }
 */

#pragma mark - BMKAnnotation protocal

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                                   reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:nil
                        action:@selector(showActionSheet:)
              forControlEvents:UIControlEventTouchUpInside];
        newAnnotationView.rightCalloutAccessoryView = rightButton;
        return newAnnotationView;
    }
    return nil;
}

#pragma mark - BMKLocationService protocal


//处理位置坐标更新
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    
    [mapView updateLocationData:userLocation];
    mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _startCoor = userLocation.location.coordinate;
    mapView.showsUserLocation = YES;//显示定位图层
    
    // NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
}

//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //    NSLog(@"heading is %@",userLocation.heading);
}

@end

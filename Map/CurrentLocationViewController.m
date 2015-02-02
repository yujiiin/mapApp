//
//  ViewController.m
//  Map
//
//  Created by Yuji Shimizu on 1/16/15.
//  Copyright (c) 2015 Yuji Shimizu. All rights reserved.
//

#import "CurrentLocationViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation CurrentLocationViewController {
    GMSMapView *mapView_;
    BOOL firstLocationUpdate_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:12];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    
    // Listen to the myLocation property of GMSMapView.
    [mapView_ addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:NULL];
    self.view = mapView_;

    locationManager = [[CLLocationManager alloc] init];
    
    // 位置情報サービスが利用できるかどうかをチェック
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager.delegate = self; // ……【1】
        // 測位開始
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        [locationManager startUpdatingLocation];
    } else {
        NSLog(@"Location services not available.");
    }
    
    // Ask for My Location data after the map has already been added to the UI.
     dispatch_async(dispatch_get_main_queue(), ^{
     mapView_.myLocationEnabled = YES;
     });
     

}

- (void)dealloc {
    NSLog(@"5");
    [mapView_ removeObserver:self forKeyPath:@"myLocation" context:NULL];
}

#pragma mark - KVO updates
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"myLocation"] && !firstLocationUpdate_)
    {
        firstLocationUpdate_ = YES;
        CLLocation *currentLocation = [change objectForKey:NSKeyValueChangeNewKey];
        mapView_.camera = [GMSCameraPosition cameraWithTarget:currentLocation.coordinate
                                                         zoom:14];
    }
}

// 位置情報更新時
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    [mapView_ animateToLocation : [newLocation coordinate]];
    
    //緯度・経度を出力
    NSLog(@"didUpdateToLocation latitude=%f, longitude=%f",
          [newLocation coordinate].latitude,
          [newLocation coordinate].longitude);
}

@end
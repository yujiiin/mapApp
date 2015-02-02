//
//  ViewController.h
//  Map
//
//  Created by Yuji Shimizu on 1/16/15.
//  Copyright (c) 2015 Yuji Shimizu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
@interface CurrentLocationViewController : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) CLLocationManager *locationManager;

@end


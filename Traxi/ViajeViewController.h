//
//  ViajeViewController.h
//  Traxi
//
//  Created by Carlos Castellanos on 21/05/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViajeViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
@property (nonatomic, retain) IBOutlet MKMapView *mapa;
@property (strong, nonatomic) CLLocationManager *LocationManager;
-(IBAction)getCurrentLocation:(id)sender;
-(IBAction)ruta:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *buscar;


@end

//
//  ViajeViewController.h
//  Traxi
//
//  Created by Carlos Castellanos on 21/05/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface ViajeViewController : UIViewController<MKMapViewDelegate>
@property (nonatomic, retain) IBOutlet MKMapView *mapa;
-(IBAction)getCurrentLocation:(id)sender;

@end

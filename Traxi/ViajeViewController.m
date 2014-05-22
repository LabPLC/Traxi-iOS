//
//  ViajeViewController.m
//  Traxi
//
//  Created by Carlos Castellanos on 21/05/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "ViajeViewController.h"

@interface ViajeViewController ()

@end

@implementation ViajeViewController
{
    MKPolyline * routeLine;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    

    _mapa.delegate=self;
    _LocationManager = [[CLLocationManager alloc] init];
    _LocationManager.delegate=self;
    _LocationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    _LocationManager.desiredAccuracy = kCLLocationAccuracyBest;// kCLLocationAccuracyHundredMeters; // 100 m
    [_LocationManager startUpdatingLocation];
    
    CLLocationCoordinate2D SCL;
    SCL.latitude = _LocationManager.location.coordinate.latitude;
    SCL.longitude = _LocationManager.location.coordinate.longitude;
    [_mapa setShowsUserLocation:YES];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(SCL, 2000, 2000);
    
    [_mapa setRegion:region animated:YES];
    
    [super viewDidLoad];
    
    
       // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)getCurrentLocation:(id)sender{
}
/*-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    CLLocation *oldLocation = [locations objectAtIndex:locations.count-1];
    NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
	MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 1500.0, 1500.0);
	
}*/
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
   
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
    {
        if ((oldLocation.coordinate.longitude != newLocation.coordinate.longitude)
            || (oldLocation.coordinate.latitude != newLocation.coordinate.latitude)) {
            
            CLLocationCoordinate2D coord = {
                .latitude = newLocation.coordinate.latitude,
                .longitude = newLocation.coordinate.longitude};
            
            MKCoordinateRegion region;
            region.center = coord;
            
            MKCoordinateSpan span = {.latitudeDelta = 0.2, .longitudeDelta = 0.2};
            region.span = span;
            
            
            //pintar ruta
            MKMapPoint * pointsArray = malloc(sizeof(CLLocationCoordinate2D)*2);
            pointsArray[0]= MKMapPointForCoordinate(CLLocationCoordinate2DMake(oldLocation.coordinate.latitude,oldLocation.coordinate.longitude));
            pointsArray[1]= MKMapPointForCoordinate(CLLocationCoordinate2DMake(newLocation.coordinate.latitude,newLocation.coordinate.longitude));
            routeLine = [MKPolyline polylineWithPoints:pointsArray count:2];
            free(pointsArray);
            [_mapa addOverlay:routeLine];
            
            
            //  [_mapa setRegion:region];
            
            NSLog(@"d");
            
        }
    }else{
          NSLog(@"a");
        if ((oldLocation.coordinate.longitude != newLocation.coordinate.longitude)
            || (oldLocation.coordinate.latitude != newLocation.coordinate.latitude)) {
            
            CLLocationCoordinate2D coord = {
                .latitude = newLocation.coordinate.latitude,
                .longitude = newLocation.coordinate.longitude};
            
            MKCoordinateRegion region;
            region.center = coord;
            
            MKCoordinateSpan span = {.latitudeDelta = 0.2, .longitudeDelta = 0.2};
            region.span = span;
            
            
            //pintar ruta
            MKMapPoint * pointsArray = malloc(sizeof(CLLocationCoordinate2D)*2);
            pointsArray[0]= MKMapPointForCoordinate(CLLocationCoordinate2DMake(oldLocation.coordinate.latitude,oldLocation.coordinate.longitude));
            pointsArray[1]= MKMapPointForCoordinate(CLLocationCoordinate2DMake(newLocation.coordinate.latitude,newLocation.coordinate.longitude));
            routeLine = [MKPolyline polylineWithPoints:pointsArray count:2];
            free(pointsArray);
            [_mapa addOverlay:routeLine];
            
            
            //  [_mapa setRegion:region];
            
            
        }
    }

}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(IBAction)ruta:(id)sender{
     [self.view endEditing:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *direccion=_buscar.text;//@"juan%20escutia%2094,la%20Condesa";
        
        
        NSData *stringData = [direccion dataUsingEncoding: NSASCIIStringEncoding allowLossyConversion: YES];
        
        direccion = [[NSString alloc] initWithData: stringData encoding: NSASCIIStringEncoding];      direccion = [direccion stringByReplacingOccurrencesOfString:@" "
                                                                                                                                                       withString:@"%20"];
        NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyDTece8Wi9Ppvy69T3YQqCBtXGTVQJAIvE&sensor=true&query=%@,distritofederal",direccion];
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        if (data!=nil) {
            
            
            NSString *dato=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSMutableString * miCadena = [NSMutableString stringWithString: dato];
            
            NSData *data1 = [miCadena dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
            NSArray *aux=[jsonObject objectForKey:@"results"];
            if ([aux count]==0) {
                UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos el lugar que buscas, intenta con otra direccón" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
                [alerta show];
            }
            else{
                NSDictionary *primero=[[jsonObject objectForKey:@"results"]objectAtIndex:0];
                NSDictionary *coordenadas=[[primero objectForKey:@"geometry"] objectForKey:@"location"];
                
                CLLocationCoordinate2D SCL;
                SCL.latitude = [[coordenadas objectForKey:@"lat"] floatValue];
                SCL.longitude = [[coordenadas objectForKey:@"lng"] floatValue];
                
                MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
                annotationPoint.coordinate = SCL;
                annotationPoint.title = @"Destino";
                // annotationPoint.subtitle = [lugar objectForKey:@"direccion"];
                [_mapa addAnnotation:annotationPoint];
                
                MKPlacemark *sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:SCL addressDictionary:nil];
                // NSLog(@"coordiante : locationIniziale %f", sourcePlacemark.coordinate.latitude);
                MKMapItem *carPosition = [[MKMapItem alloc] initWithPlacemark:sourcePlacemark];
                MKMapItem *actualPosition = [MKMapItem mapItemForCurrentLocation];
                // NSLog(@"coordiante : source %f, ActualPosition %f", carPosition.placemark.coordinate.latitude ,actualPosition.placemark.coordinate.latitude);
                MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
                request.source = actualPosition;
                request.destination = carPosition;
                request.requestsAlternateRoutes = YES;
                
                MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
                [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                    if (error) {
                        NSLog(@"Error : %@", error);
                    }
                    else {
                        [self showDirections:response]; //response is provided by the CompletionHandler
                    }
                }];

                
                          }
        }
        else{
            
            UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos el lugar que buscas, intenta con otra direccón" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alerta show];
        }
        
    });
   
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
        routeRenderer.strokeColor = [UIColor redColor];
        return routeRenderer;
    }
    else return nil;
}
- (void)showDirections:(MKDirectionsResponse *)response
{
    int i=0;
    for (MKRoute *route in response.routes) {
        if (i<1) {
            [_mapa addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
            i++;
        }
        
    }
}



//

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id )overlay

{
    
    MKOverlayView* overlayView = nil;
    
    MKPolylineView  * routeLineView = [[MKPolylineView alloc] initWithPolyline:routeLine];
    
    
    routeLineView.fillColor = [UIColor redColor];
    
    routeLineView.strokeColor = [UIColor orangeColor];
    
    routeLineView.lineWidth = 1;
    
    overlayView = routeLineView;
    
    return overlayView;
    
}
@end

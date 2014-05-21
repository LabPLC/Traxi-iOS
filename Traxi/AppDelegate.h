//
//  AppDelegate.h
//  Traxi
//  @rockarloz
//  Created by Carlos Castellanos on 23/04/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
 @property (strong, nonatomic) NSString *placa;

@property (strong, nonatomic) NSString *marca;
@property (strong, nonatomic) NSString *submarca;
@property (strong, nonatomic) NSString *anio;
@property (strong, nonatomic) NSArray * infracciones;
@property (strong, nonatomic) NSMutableDictionary * tenencias;
@property (strong, nonatomic) NSMutableArray * verificaciones;
@property (retain, nonatomic) NSString *registrado;
@property (strong, nonatomic) NSString *verificado;
@property (strong, nonatomic) NSString *alto;
@end

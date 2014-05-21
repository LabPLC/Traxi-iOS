//
//  InicioViewController.h
//  Traxi
//
//  Created by Carlos Castellanos on 20/05/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InicioViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *letra;
@property (weak, nonatomic) IBOutlet UITextField *numeros;
- (IBAction)takePhoto:(UIButton *)sender;
@end

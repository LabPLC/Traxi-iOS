//
//  ViewController.h
//  Traxi
//  @rockarloz
//  rockarlos@me.com
//  Created by Carlos Castellanos on 23/04/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nombre;
@property (weak, nonatomic) IBOutlet UITextField *correo;

@property (weak, nonatomic) IBOutlet UITextField *numero1;
@property (weak, nonatomic) IBOutlet UITextField *correo1;
@property (weak, nonatomic) IBOutlet UITextField *numero2;
@property (weak, nonatomic) IBOutlet UITextField *correo2;
@property (weak, nonatomic) IBOutlet UIImageView *foto;


@property (weak, nonatomic) IBOutlet UIView *foto_aux;
- (IBAction)showPicker:(id)sender;

@end

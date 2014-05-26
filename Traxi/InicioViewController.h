//
//  InicioViewController.h
//  Traxi
//
//  Created by Carlos Castellanos on 20/05/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InicioViewController : UIViewController <UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *letra;
@property (weak, nonatomic) IBOutlet UIImageView *imagen;
@property (weak, nonatomic) IBOutlet UIPageControl *pagecontrol;
//tips
@property (weak, nonatomic) IBOutlet UIView *scroll_view;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UITextField *numeros;
-(IBAction)cerrar_tips:(id)sender;
-(IBAction)tips:(id)sender;
//
- (IBAction)takePhoto:(UIButton *)sender;
-(IBAction)verificar:(id)sender;
- (IBAction)save:(id)sende;
@end


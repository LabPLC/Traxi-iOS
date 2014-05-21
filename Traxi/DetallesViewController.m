//
//  DetallesViewController.m
//  Traxi
//
//  Created by Carlos Castellanos on 20/05/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "DetallesViewController.h"

@interface DetallesViewController ()

@end

@implementation DetallesViewController

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
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
     paginas=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    [super viewDidLoad];
    for (int i = 0; i < [paginas count]; i++) {
        if (i==0) {
            UIView *fondo;
            UIImageView *imageView;
            UILabel *lbldatos;
            UILabel *datos;
            CGRect frame;
            CGRect frame_fondo;
            CGRect frame2;
            CGRect frame_argumento;
            
          /*  if ( [delegate.alto intValue] < 568) {
                
                
                frame.origin.x = (self.scroll.frame.size.width * i)+65;
                frame.origin.y = 15;
                frame.size.height =150;
                frame.size.width=150;
                imageView = [[UIImageView alloc] initWithFrame:frame];
                
                
                frame2.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame2.origin.y = frame.size.height+10;
                frame2.size.height =60;
                frame2.size.width=250;//self.scrollView.frame.size; ancho
                registro=[[UILabel alloc]initWithFrame:frame2];
                [registro setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
                
                registro.numberOfLines = 2;
                registro.textAlignment = NSTextAlignmentCenter;
                
                
                frame_argumento.origin.x = (self.scroll.frame.size.width * i)+20;
                frame_argumento.origin.y = frame.size.height+60;
                frame_argumento.size.height =83;
                frame_argumento.size.width=240;//self.scrollView.frame.size; ancho
                argumento=[[UILabel alloc]initWithFrame:frame_argumento];
                [argumento setFont:[UIFont systemFontOfSize:12]];
                argumento.numberOfLines = 6;
                argumento.textAlignment = NSTextAlignmentCenter;
            }
            
            else{*/
            
                frame_fondo.origin.x = (self.scroll.frame.size.width * i)+15;
                frame_fondo.origin.y = 5;
                frame_fondo.size.height =50;
                frame_fondo.size.width=self.scroll.frame.size.width -20;//self.scrollView.frame.size;
                fondo = [[UIView alloc] initWithFrame:frame_fondo];
                fondo.backgroundColor=[UIColor lightGrayColor];
            
                lbldatos=[[UILabel alloc]initWithFrame:CGRectMake(3, 5, fondo.frame.size.width-20, 20)];
                [lbldatos setFont:[UIFont systemFontOfSize:12]];
                lbldatos.textAlignment = NSTextAlignmentLeft;
                lbldatos.text=@"Datos del vehículo";
                [fondo addSubview:lbldatos];
            
                datos=[[UILabel alloc]initWithFrame:CGRectMake(3, 30, fondo.frame.size.width-20, 20)];
                [datos setFont:[UIFont systemFontOfSize:14]];
                datos.textAlignment = NSTextAlignmentLeft;
                datos.text=@"VOLKWAGEN,POINTER,2007";
                [fondo addSubview:datos];
            
                frame.origin.x = (self.scroll.frame.size.width * i)+50;
                frame.origin.y = 60;
                frame.size.height =270;
                frame.size.width=220;//self.scrollView.frame.size;
                imageView = [[UIImageView alloc] initWithFrame:frame];
                imageView.image = [UIImage imageNamed:@"yisus.jpg"];
                //label
                
                
            
            //}
            
            
            
            
           /* if ([delegate.registrado isEqualToString:@"true"]) {
            
                registro.text=@"Esta placa SI se encuentra registrada como taxi con SETRAVI";
                registro.textColor=[UIColor colorWithRed:0.784f green:0.718f blue:0.588f alpha:1.0f];
                argumento.text=@"Esto significa que este vehículo está al día en trámites como: revista vehicular, verificación de taxímetro y regularidad en el estado de concesión de servicio de taxi.";
                
                
            }
            else{
                imageView.image = [UIImage imageNamed:@"Taxi_No.png"];
                registro.text=@"Esta placa NO se encuentra registrada como taxi con SETRAVI";
                registro.textColor=[UIColor colorWithRed:0.557f green:0.031f blue:0.051f alpha:1.0f];
                argumento.text=@"Si abordas este vehículo, sugerimos que lo hagas con precaución. Es posible que este vehículo tenga algún trámite pendiente o esté operando de manera ilegal.";
                
            }*/
            
           // [argumento adjustsFontSizeToFitWidth];
            //[registro adjustsFontSizeToFitWidth];
            //[self.scroll addSubview:argumento];
            //[self.scroll addSubview:registro];
            [self.scroll addSubview:imageView];
             [self.scroll addSubview:fondo];

        
        }
        else if (i==1){
        
            UIView *linea;
            UILabel *lbldatos;
            UILabel *datos;
            UIImageView *imageView;
            CGRect frame_linea;
         
            UIView *linea2;
            UILabel *lbldatos2;
            UILabel *datos2;
            UIImageView *imageView2;
            
            UIView *linea3;
            UILabel *lbldatos3;
            UILabel *datos3;
            UIImageView *imageView3;
            
            UIView *linea4;
            UILabel *lbldatos4;
            UILabel *datos4;
            UIImageView *imageView4;
            
            UIView *linea5;
            UILabel *lbldatos5;
            UILabel *datos5;
            UIImageView *imageView5;
            
            lbldatos=[[UILabel alloc]initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+15), 5, 150, 20)];
            [lbldatos setFont:[UIFont systemFontOfSize:12]];
            lbldatos.textAlignment = NSTextAlignmentLeft;
            lbldatos.text=@"Revista vehicular";
            [_scroll addSubview:lbldatos];
            
            frame_linea.origin.x = (self.scroll.frame.size.width * i)+15;
            frame_linea.origin.y = 25;
            frame_linea.size.height =2;
            frame_linea.size.width=self.scroll.frame.size.width -20;//self.scrollView.frame.size;
            linea = [[UIView alloc] initWithFrame:frame_linea];
            linea.backgroundColor=[UIColor lightGrayColor];
            [_scroll addSubview:linea];
            
            datos=[[UILabel alloc]initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+15), 26, 150, 20)];
            [datos setFont:[UIFont systemFontOfSize:12]];
            datos.textAlignment = NSTextAlignmentLeft;
            datos.text=@"Este vehículo es regular";
            [_scroll addSubview:datos];
            
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+270), 26, 30, 30)];

            imageView.image = [UIImage imageNamed:@"usuario.png"];
            [_scroll addSubview:imageView];
        
        }
        else if (i==2){}
    }
    _scroll.contentSize = CGSizeMake(_scroll.frame.size.width * [paginas count], _scroll.frame.size.height);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scroll.frame.size.width;
    int page = floor((self.scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pagecontrol.currentPage = page;
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

@end

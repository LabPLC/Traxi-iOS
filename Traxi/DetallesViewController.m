//
//  DetallesViewController.m
//  Traxi
//
//  Created by Carlos Castellanos on 20/05/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "DetallesViewController.h"
#import "AppDelegate.h"
@interface DetallesViewController ()

@end

@implementation DetallesViewController
{
    AppDelegate *delegate;
    NSArray *comentarios;
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
    _tableView = [[UITableView alloc]  init ];
    
    _tableView.dataSource   = self;
    _tableView.delegate     = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *url=[NSString stringWithFormat:(@"http://datos.labplc.mx/~mikesaurio/taxi.php?act=pasajero&type=getcomentario&placa=%@"),delegate.placa];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        if ([data length] >0  )
        {
            NSString *dato=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSMutableString * miCadena = [NSMutableString stringWithString: dato];
            NSData *data1 = [miCadena dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
            
            NSMutableDictionary *consulta=[[NSMutableDictionary alloc]init];
            consulta = [jsonObject objectForKey:@"message"];
            comentarios=[consulta objectForKey:@"calificacion"];
            [_tableView reloadData];

        }
    });
    delegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //http://datos.labplc.mx/~mikesaurio/taxi.php?act=pasajero&type=getcomentario&placa=a05601
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
     paginas=[[NSArray alloc]initWithObjects:@"1",@"2",@"3", nil];
    [super viewDidLoad];
    for (int i = 0; i < [paginas count]; i++) {
        
        if (i==0) {
            UIView *fondo;
            UIView *fondo_calificacion;
            UIImageView *imageView;
            UILabel *lbldatos;
            UILabel *datos;
            CGRect frame;
            CGRect frame_fondo;
          
            
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
                lbldatos.text=[NSString stringWithFormat: (@"Datos del vehículo: %@"),delegate.placa];
                [fondo addSubview:lbldatos];
            
                datos=[[UILabel alloc]initWithFrame:CGRectMake(3, 30, fondo.frame.size.width-20, 20)];
                [datos setFont:[UIFont systemFontOfSize:14]];
                datos.textAlignment = NSTextAlignmentLeft;
                datos.text=[NSString stringWithFormat: (@"%@,%@,%@"),delegate.marca,delegate.submarca,delegate.anio];
                [fondo addSubview:datos];
            
            
                fondo_calificacion = [[UIView alloc] initWithFrame:CGRectMake((self.scroll.frame.size.width * i)+30, 65, 240, 270)];
                fondo_calificacion.backgroundColor=[UIColor greenColor];
            
                frame.origin.x = (self.scroll.frame.size.width * i)+30;
                frame.origin.y = 65;
                frame.size.height =270;
                frame.size.width=240;//self.scrollView.frame.size;
                imageView = [[UIImageView alloc] initWithFrame:frame];
                imageView.image = [UIImage imageNamed:@"escudo.png"];
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
             [self.scroll addSubview:fondo_calificacion];
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
            
            datos=[[UILabel alloc]initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+15), 26, 200, 20)];
            [datos setFont:[UIFont systemFontOfSize:12]];
            datos.textAlignment = NSTextAlignmentLeft;
            datos.text=delegate.registrado;
            [_scroll addSubview:datos];
            
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+270), 26, 30, 30)];

            imageView.image = [UIImage imageNamed:@"usuario.png"];
            [_scroll addSubview:imageView];
            
            ///// 2
            
            lbldatos2=[[UILabel alloc]initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+15), 70, 150, 20)];
            [lbldatos2 setFont:[UIFont systemFontOfSize:12]];
            lbldatos2.textAlignment = NSTextAlignmentLeft;
            lbldatos2.text=@"Infracciones";
            [_scroll addSubview:lbldatos2];
            
            linea2 = [[UIView alloc] initWithFrame:CGRectMake((self.scroll.frame.size.width * i)+15, 90, self.scroll.frame.size.width -20, 2)];
            linea2.backgroundColor=[UIColor lightGrayColor];
            [_scroll addSubview:linea2];
            
            datos2=[[UILabel alloc]initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+15), 91, 200, 20)];
            [datos2 setFont:[UIFont systemFontOfSize:12]];
            datos2.textAlignment = NSTextAlignmentLeft;
           
           
            [_scroll addSubview:datos2];
            
            imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+270), 91, 30, 30)];
            
            
            
            //////ver infracciones pagadas y no pagas
            
            
            if ([delegate.infracciones count]==0) {
                datos2.text=@"Este vehículo no tiene multas";
                imageView2.image = [UIImage imageNamed:@"paloma.png"];
            }
            else{
                
                int infracciones=0;
                // infracciones.text=[NSString stringWithFormat:@"%i",[delegate.infracciones count]];
                for (int i=0; i< [delegate.infracciones count]; i++) {
                    
                    if([[[delegate.infracciones objectAtIndex:i]objectForKey:@"situacion"] isEqualToString:@"Pagada"]){
                        infracciones=infracciones+1;
                    }
                    
                }
                if ([delegate.infracciones count] - infracciones!=0) {
                    datos2.text=@"Este vehículo  tiene multas";
                    imageView2.image = [UIImage imageNamed:@"tache.png"];
                }
                else{
                    datos2.text=@"Este vehículo no tiene multas";
                    imageView2.image = [UIImage imageNamed:@"paloma.png"];
                    
                }
                
                
            }
            
            [_scroll addSubview:imageView2];
          
            ////3
            lbldatos3=[[UILabel alloc]initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+15), imageView2.frame.origin.y +35, 150, 20)];
            [lbldatos3 setFont:[UIFont systemFontOfSize:12]];
            lbldatos3.textAlignment = NSTextAlignmentLeft;
            lbldatos3.text=@"Vehiculo.";
            [_scroll addSubview:lbldatos3];
            
            linea3 = [[UIView alloc] initWithFrame:CGRectMake((self.scroll.frame.size.width * i)+15, lbldatos3.frame.origin.y +20, self.scroll.frame.size.width -20, 2)];
            linea3.backgroundColor=[UIColor lightGrayColor];
            [_scroll addSubview:linea3];
            
            datos3=[[UILabel alloc]initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+15), linea3.frame.origin.y +1, 200, 20)];
            [datos3 setFont:[UIFont systemFontOfSize:12]];
            datos3.textAlignment = NSTextAlignmentLeft;
            
            [_scroll addSubview:datos3];
            
            imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+270), linea3.frame.origin.y +1, 30, 30)];
            
            int año=2014-[delegate.anio integerValue];
            if (año>10) {
                datos3.text=[NSString stringWithFormat:@"Este vehículo no es óptimo. Año %@",delegate.anio];
                imageView3.image = [UIImage imageNamed:@"tache.png"];
            }
            else{
                datos3.text=[NSString stringWithFormat:@"Este vehículo  es óptimo. Año %@",delegate.anio];
                imageView3.image = [UIImage imageNamed:@"paloma.png"];
            }

            [_scroll addSubview:imageView3];
            
            ////4
            lbldatos4=[[UILabel alloc]initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+15), imageView3.frame.origin.y +35, 150, 20)];
            [lbldatos4 setFont:[UIFont systemFontOfSize:12]];
            lbldatos4.textAlignment = NSTextAlignmentLeft;
            lbldatos4.text=@"Verificaciones.";
            [_scroll addSubview:lbldatos4];
            
            linea4 = [[UIView alloc] initWithFrame:CGRectMake((self.scroll.frame.size.width * i)+15, lbldatos4.frame.origin.y +20, self.scroll.frame.size.width -20, 2)];
            linea4.backgroundColor=[UIColor lightGrayColor];
            [_scroll addSubview:linea4];
            
            datos4=[[UILabel alloc]initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+15), linea4.frame.origin.y +1, 200, 20)];
            [datos4 setFont:[UIFont systemFontOfSize:12]];
            datos4.textAlignment = NSTextAlignmentLeft;
            datos4.text=delegate.registrado;
            [_scroll addSubview:datos4];
            
            imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+270), linea4.frame.origin.y +1, 30, 30)];
            
            imageView4.image = [UIImage imageNamed:@"usuario.png"];
            [_scroll addSubview:imageView4];
            ////5
            lbldatos5=[[UILabel alloc]initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+15), imageView4.frame.origin.y +35, 150, 20)];
            [lbldatos5 setFont:[UIFont systemFontOfSize:12]];
            lbldatos5.textAlignment = NSTextAlignmentLeft;
            lbldatos5.text=@"Tenencia.";
            [_scroll addSubview:lbldatos5];
            
            linea5 = [[UIView alloc] initWithFrame:CGRectMake((self.scroll.frame.size.width * i)+15, lbldatos5.frame.origin.y +20, self.scroll.frame.size.width -20, 2)];
            linea5.backgroundColor=[UIColor lightGrayColor];
            [_scroll addSubview:linea5];
            
            datos5=[[UILabel alloc]initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+15), linea5.frame.origin.y +1, 200, 20)];
            [datos5 setFont:[UIFont systemFontOfSize:12]];
            datos5.textAlignment = NSTextAlignmentLeft;
            datos5.text=delegate.registrado;
            [_scroll addSubview:datos5];
            
            imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(((self.scroll.frame.size.width * i)+270), linea5.frame.origin.y +1, 30, 30)];
            
            imageView5.image = [UIImage imageNamed:@"usuario.png"];
            [_scroll addSubview:imageView5];
            
        
        }
        else if (i==2){
        
          CGRect  frame_tabla=CGRectMake((self.scroll.frame.size.width * i)+15, 15, 300, 300);
            _tableView.frame=frame_tabla;
            
            _tableView.rowHeight=40;
           // [_tableView setBackgroundColor:[UIColor blackColor]];
          
            [_scroll addSubview:_tableView];
            [_tableView reloadData];
        
        
        
        }
    }
    _scroll.contentSize = CGSizeMake(_scroll.frame.size.width * [paginas count], _scroll.frame.size.height);
    
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [comentarios count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
    }
    
    // Configure the cell...
    cell.textLabel.text = [[comentarios objectAtIndex:indexPath.row]objectForKey:@"comentario"];
    
    return cell;}

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

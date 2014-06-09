//
//  eventCell.m
//  DejateCaer
//  @rockarloz
//  rockarlos@me.com
//  Created by Carlos Castellanos on 12/03/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "eventCell.h"

@implementation eventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // self.backgroundColor=[UIColor colorWithRed:(243/255.0) green:(23/255.0) blue:(52/255.0) alpha:1];
        self.backgroundColor=[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
        
        
       // [self addSubview:circleView];
        // Initialization code
       
        UIView *selectedView = [[UIView alloc]init];
        selectedView.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:0 green:0 blue:255 alpha:0.3];
        
        _fecha=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 230, 70)];
        _fecha.textColor=[UIColor grayColor];
        _fecha.numberOfLines = 3;
       // _fecha.text=@"dsfsdfsd";
        
        [self   addSubview:_fecha];
        
        _hora=[[UILabel alloc]initWithFrame:CGRectMake(200, 60, 300, 34)];
        _hora.textColor=[UIColor redColor];
        //[_hora setFont:[UIFont systemFontOfSize:10]];
    //    _hora.text=@"dsfsdfsd";

        [self   addSubview:_hora];
     
        _comentario=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, 70, 34)];
      
      //_comentario.text=@"dsfsdfsd";
        _comentario.textColor=[UIColor redColor];
        // [_distancia setFont:[UIFont systemFontOfSize:14]];
             [self    addSubview:_comentario];
        
       // cell.selectedBackgroundView =  selectedView;
        self.selectedBackgroundView=selectedView;
       // self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
   // self.backgroundColor=[UIColor yellowColor];
    // Configure the view for the selected state
}

@end

//
//  CalificarViewController.h
//  Traxi
//
//  Created by Carlos Castellanos on 22/05/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPFloatRatingView.h"
@interface CalificarViewController : UIViewController<TPFloatRatingViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;
@property (strong, nonatomic) IBOutlet UILabel *liveLabel;
@property (strong, nonatomic) IBOutlet TPFloatRatingView *ratingView;

@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

//
//  CalificarViewController.m
//  Traxi
//
//  Created by Carlos Castellanos on 22/05/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "CalificarViewController.h"

@interface CalificarViewController ()

@end

@implementation CalificarViewController

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
    
    self.ratingView.delegate = self;
    self.ratingView.emptySelectedImage = [UIImage imageNamed:@"star1.png"];
    self.ratingView.fullSelectedImage = [UIImage imageNamed:@"star2.png"];
    self.ratingView.contentMode = UIViewContentModeScaleAspectFill;
    self.ratingView.maxRating = 5;
    self.ratingView.minRating = 0;
    self.ratingView.rating = 2.5;
    self.ratingView.editable = YES;
    self.ratingView.halfRatings = YES;
    self.ratingView.floatRatings = NO;
    
    self.ratingLabel.text = [NSString stringWithFormat:@"%.2f", self.ratingView.rating];
    self.liveLabel.text = [NSString stringWithFormat:@"%.2f", self.ratingView.rating];
    

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TPFloatRatingViewDelegate

- (void)floatRatingView:(TPFloatRatingView *)ratingView ratingDidChange:(CGFloat)rating
{
    self.ratingLabel.text = [NSString stringWithFormat:@"%.2f", rating];
}

- (void)floatRatingView:(TPFloatRatingView *)ratingView continuousRating:(CGFloat)rating
{
    self.liveLabel.text = [NSString stringWithFormat:@"%.2f", rating];
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

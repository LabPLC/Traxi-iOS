//
//  DetallesViewController.h
//  Traxi
//
//  Created by Carlos Castellanos on 20/05/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetallesViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSArray *paginas;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pagecontrol;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@end

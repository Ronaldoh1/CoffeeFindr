//
//  DetailViewController.h
//  CoffeeFindr
//
//  Created by Ronald Hernandez on 3/7/15.
//  Copyright (c) 2015 Ronald Hernandez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoffeePlace.h"

@interface DetailViewController : UIViewController

@property CoffeePlace *coffePlace;
@property CLLocation *currentLocation;

@end

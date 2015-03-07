//
//  CoffeePlace.h
//  CoffeeFindr
//
//  Created by Ronald Hernandez on 3/6/15.
//  Copyright (c) 2015 Ronald Hernandez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CoffeePlace : NSObject

@property MKMapItem *mapItem;
@property float milesDifference;

@end

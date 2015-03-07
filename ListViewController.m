//
//  ListViewController.m
//  CoffeeFindr
//
//  Created by Ronald Hernandez on 3/6/15.
//  Copyright (c) 2015 Ronald Hernandez. All rights reserved.
//

#import "ListViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CoffeePlace.h"


@interface ListViewController () <CLLocationManagerDelegate>
@property CLLocationManager *locationManager;
@property CLLocation *currentLocation;
@property NSArray *coffeePlacesArray;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self updateCurrentLocation];


}

//helper method to obtain user's location

-(void) updateCurrentLocation{

    [self.locationManager requestAlwaysAuthorization]; // promp the user to request the user's location

    [self.locationManager startUpdatingLocation];

}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    self.currentLocation = locations.firstObject;
    NSLog(@"%@", self.currentLocation);
    [self.locationManager stopUpdatingLocation];
    [self findCoffeePlaces:self.currentLocation];
}
-(void)findCoffeePlaces:(CLLocation *)location{

    MKLocalSearchRequest *request = [MKLocalSearchRequest new];

    request.naturalLanguageQuery = @"coffee";

    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(.05, .05));

    // make a local search

    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        NSArray *mapItems = response.mapItems;
        NSMutableArray *tempArray = [NSMutableArray new];
        
        for (int i = 0; i<5; i++){

            MKMapItem *mapItem = [mapItems objectAtIndex:i];
            CLLocationDistance metersAway = [mapItem.placemark.location distanceFromLocation:location];
            float milesDifference = metersAway / 1609.34;

            CoffeePlace *coffeePlace = [CoffeePlace new];
            coffeePlace.mapItem = mapItem;
            coffeePlace.milesDifference = milesDifference;

            [tempArray addObject:coffeePlace];

            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"milesDifference" ascending: true];
            NSArray *sortedArray = [tempArray sortedArrayUsingDescriptors:@[sortDescriptor]];

            self.coffeePlacesArray = [NSArray arrayWithArray:sortedArray];

            for (CoffeePlace *coffeePlace in self.coffeePlacesArray){
                NSLog(@"%f", coffeePlace.milesDifference);

            }


        }

    }];
}


@end

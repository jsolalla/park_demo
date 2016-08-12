//
//  Tools.swift
//  Parkiller Demo
//
//  Created by Jesus Santa Olalla on 8/11/16.
//  Copyright © 2016 jsolalla. All rights reserved.
//

import Foundation
import CoreLocation

class Tools {
    
    func getDistanceInMeters(currentLocation:CLLocation?, newLocation:CLLocation) -> CLLocationDistance? {
        
        if let currentLocation = currentLocation {
           return currentLocation.distanceFromLocation(newLocation)
        }
        
        return nil
    }
    
}
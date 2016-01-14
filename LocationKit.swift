//
//  LocationKit.swift
//  LocationKit
//
//  Created by Marcus Ronélius on 2016-01-13.
//  Copyright © 2016 Ronelium Applications. All rights reserved.
//

import Foundation
import CoreLocation

public class LocationKit {    
    // Shared instance
    class func sharedInstance() -> LocationKit {
        struct Singleton {
            static var sharedInstance = LocationKit()
        }
        return Singleton.sharedInstance
    }
    
    public init() {
        print("LocationKit has been initialized")
    }
    
    public func getCurrentLocation(completionHandler: (location: CLLocation?, error: NSError?) -> Void) {
        let locationKitClient = LocationKitClient()
        locationKitClient.sharedInstance().getCurrentLocation { (location, error) -> Void in
            completionHandler(location: location, error: error)
        }
        
    }
}
//
//  RALocationKit.swift
//  RALocationKit
//
//  Created by Marcus Ronélius on 2016-01-13.
//  Copyright © 2016 Ronelium Applications. All rights reserved.
//

import Foundation
import CoreLocation

public class RALocationKit {    
    // Shared instance
    class func sharedInstance() -> RALocationKit {
        struct Singleton {
            static var sharedInstance = RALocationKit()
        }
        return Singleton.sharedInstance
    }
    
    public init() {
        print("RALocationKit has been initialized")
    }
    
    public func getCurrentLocation(completionHandler: (location: CLLocation?, error: NSError?) -> Void) {
        let locationKitClient = RALocationKitClient()
        locationKitClient.sharedInstance().getCurrentLocation { (location, error) -> Void in
            completionHandler(location: location, error: error)
        }
        
    }
}
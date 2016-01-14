//
//  LocationKitConvenience.swift
//  LocationKitLab
//
//  Created by Marcus Ronélius on 2016-01-13.
//  Copyright © 2016 Ronelium Applications. All rights reserved.
//

import Foundation
import CoreLocation

extension LocationKitClient {
    
    func getCurrentLocation(completionHandler: (location: CLLocation?, error: NSError?) -> Void) {
        do {
            try updateLocation({ (location, error) -> Void in
                
                if let location = location {
                    completionHandler(location: location, error: nil)
                } else {
                    // Error, should occur if locationManager fails retreiving location or if user is not authorized after changing status
                    completionHandler(location: nil, error: self.generateNSError(error!))
                }
            })
        } catch LocationKitError.BadAuthorization(AuthorizationStatus.Restricted) {
            completionHandler(location: nil, error: self.generateNSError(LocationKitError.BadAuthorization(AuthorizationStatus.Restricted)))
        } catch LocationKitError.BadAuthorization(AuthorizationStatus.Denied) {
            completionHandler(location: nil, error: self.generateNSError(LocationKitError.BadAuthorization(AuthorizationStatus.Denied)))
        } catch LocationKitError.BadAuthorization(AuthorizationStatus.NotDetermined) {
            completionHandler(location: nil, error: self.generateNSError(LocationKitError.BadAuthorization(AuthorizationStatus.NotDetermined)))
        } catch let unknownError {
            // Shouldnt come here
            print(unknownError)
            completionHandler(location: nil, error: self.generateNSError(LocationKitError.BadAuthorization(.GeneralError)))
        }
    }
}
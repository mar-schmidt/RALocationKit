//
//  RALocationKitConvenience.swift
//  RALocationKitLab
//
//  Created by Marcus Ronélius on 2016-01-13.
//  Copyright © 2016 Ronelium Applications. All rights reserved.
//

import Foundation
import CoreLocation

extension RALocationKitClient {
    
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
        } catch RALocationKitError.BadAuthorization(AuthorizationStatus.Restricted) {
            completionHandler(location: nil, error: self.generateNSError(RALocationKitError.BadAuthorization(AuthorizationStatus.Restricted)))
        } catch RALocationKitError.BadAuthorization(AuthorizationStatus.Denied) {
            completionHandler(location: nil, error: self.generateNSError(RALocationKitError.BadAuthorization(AuthorizationStatus.Denied)))
        } catch RALocationKitError.BadAuthorization(AuthorizationStatus.NotDetermined) {
            completionHandler(location: nil, error: self.generateNSError(RALocationKitError.BadAuthorization(AuthorizationStatus.NotDetermined)))
        } catch let unknownError {
            // Shouldnt come here
            print(unknownError)
            completionHandler(location: nil, error: self.generateNSError(RALocationKitError.BadAuthorization(.GeneralError)))
        }
    }
}
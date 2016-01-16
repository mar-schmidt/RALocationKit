//
//  RALocationKitClient.swift
//  RALocationKitLab
//
//  Created by Marcus Ronélius on 2016-01-13.
//  Copyright © 2016 Ronelium Applications. All rights reserved.
//

import Foundation
import CoreLocation

class RALocationKitClient: NSObject, CLLocationManagerDelegate {
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        
        return locationManager
    }()
    
    // Completion handler is used to report back to RALocationKitConvenience
    typealias locationCompletionHandler = (location: CLLocation?, error: RALocationKitError?) -> Void
    var completionHandler: locationCompletionHandler?
    
    // locationManagers requestLocation seems to be fireing multiple times. we do not want that
    var locationsReceived: Bool = false
    
    // Accuracy that is set at the interface.
    var accuracy: CLLocationAccuracy?
    
    // Shared instance
    func sharedInstance() -> RALocationKitClient {
        struct Singleton {
            static var sharedInstance = RALocationKitClient()
        }
        return Singleton.sharedInstance
    }
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        // Set the accuracy if its available, otherwise set it to nearest ten meters
        if let accuracy = accuracy {
            self.locationManager.desiredAccuracy = accuracy
        } else {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }
    
    func updateLocation(completion: locationCompletionHandler) throws -> Void {
        completionHandler = completion
        
        let authorization = self.isAuthorized()
        
        // 0 = Authorized, 1 = CLAuthorizationStatus
        if authorization.0 {
            self.locationManager.requestLocation()
        } else {
            // Not authorized
            if authorization.1 == RALocationKitClient.AuthorizationStatus.NotDetermined {
                if (NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationAlwaysUsageDescription") != nil) {
                    self.locationManager.requestAlwaysAuthorization()
                    return
                } else if (NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationWhenInUseUsageDescription") != nil) {
                    self.locationManager.requestWhenInUseAuthorization()
                    return
                } else {
                    print("\nRALocationKit:\nPlease set option\n\"NSLocationWhenInUseUsageDescription\"\nor\n\"NSLocationAlwaysUsageDescription\"\nin your info.plist before use\n")
                }
            }
            // Throw error since user has probably choosen not to accept location tracking
            throw RALocationKitError.BadAuthorization(authorization.1)
        }
    }
    
    // MARK: CLLocationManagerDelegate methods
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if !self.locationsReceived {
                self.locationsReceived = true
                completionHandler!(location: location, error: nil)
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.locationManager.stopUpdatingLocation()
        
        completionHandler!(location: nil, error: generatedLocationError(error))
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        let authorization = self.isAuthorized()
        
        // 0 = Authorized, 1 = CLAuthorizationStatus
        if authorization.0 {
            self.locationManager.requestLocation()
        }
        // Not authorized. If not determine, ask for authorization. Else return error with completionHandler
        switch authorization.1 {
        case .NotDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestAlwaysAuthorization()
            break
        case .Working:
            break
        default:
            let authParam: [String : AnyObject] = [
                "AuthorizationStatus": "\(authorization.1)"
            ]
            completionHandler!(location: nil, error: generatedLocationError(NSError(domain: "AuthorizationStatus", code: 0, userInfo: authParam)))
        }
    }
    
    /* Helper: Check if we are authorized to perform locationupdates */
    private func isAuthorized() -> (Bool, AuthorizationStatus) {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .Restricted:
            return (false, .Restricted)
        case .Denied:
            return (false, .Denied)
        case .NotDetermined:
            return (false, .NotDetermined)
        case .AuthorizedWhenInUse:
            return (true, .Working)
        default:
            return (true, .Working)
        }
    }
}

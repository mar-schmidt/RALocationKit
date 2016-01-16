//
//  RALocationKitErrorHandler.swift
//  RALocationKitLab
//
//  Created by Marcus Ronélius on 2016-01-13.
//  Copyright © 2016 Ronelium Applications. All rights reserved.
//

import Foundation

extension RALocationKitClient {
    enum RALocationKitError: ErrorType {
        case BadAuthorization(AuthorizationStatus)
        case OK
    }
    
    enum AuthorizationStatus: ErrorType {
        case Restricted
        case Denied
        case NotDetermined
        case Working
        case GeneralError
    }
    
    func generatedLocationError(error: NSError?) -> RALocationKitError? {
        
        guard (error == nil) else {
            return self.handleNSError(error!)
        }
        
        return nil
    }
    
    internal func handleNSError(error: NSError) -> RALocationKitError {
        switch error.userInfo["AuthorizationStatus"] {
        case "Restricted" as String:
            return RALocationKitError.BadAuthorization(.Restricted)
        case "Denied" as String:
            return RALocationKitError.BadAuthorization(.Denied)
        case "NotDetermined" as String:
            return RALocationKitError.BadAuthorization(.NotDetermined)
        default:
            return RALocationKitError.BadAuthorization(.GeneralError)
        }
    }
    
    internal func generateNSError(error: RALocationKitError) -> NSError {
        switch error {
        case .BadAuthorization(.Restricted):
            return nsErrorWithCode(0, authStatus: "Restricted")
        case .BadAuthorization(.Denied):
            return nsErrorWithCode(1, authStatus: "Denied")
        case .BadAuthorization(.NotDetermined):
            return nsErrorWithCode(2, authStatus: "NotDetermined")
        case .BadAuthorization(.Working):
            return nsErrorWithCode(3, authStatus: "Working")
        case .BadAuthorization(.GeneralError):
            return nsErrorWithCode(4, authStatus: "GeneralError")
        default:
            return nsErrorWithCode(4, authStatus: "GeneralError")
        }
    }
    
    private func nsErrorWithCode(errorCode: Int, authStatus: String) -> NSError {
        let authParam: [String : AnyObject] = [
            NSLocalizedDescriptionKey: "\(authStatus)"
        ]
        
        return NSError(domain: "AuthorizationStatus", code: errorCode, userInfo: authParam)
    }
}
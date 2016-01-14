# LocationKit - The CoreLocation wrapper

[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)

Get the location of the user in just a few lines of code. This CoreLocation wrapper makes your location handling a blast!
This framework makes your life easier when it comes to location-handling in your Swift application. It makes use of completion-block instead of delegate pattern, for a convenient and clean implementation.

#Installation
The framework require a minimum deployment target of iOS 9
##Manual (more to come)
Simply copy files `LocationKit.swift`, `LocationKitClient.swift`, `LocationKitConvenience.swift`, `LocationKitErrorHandler.swift` to your Xcode project

#Getting started
##Initialise
To begin with, you have to initialise the LocationKit instance.
```swift
let locationKit = LocationKit()
```

##Getting the first CLLocation object
```swift
locationKit.getCurrentLocation { (location, error) -> Void in
  if let location = location {
    ....
  } else {
    ....
  }
}


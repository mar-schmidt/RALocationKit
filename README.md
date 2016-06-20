# RALocationKit - The CoreLocation wrapper

[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![CI Status](http://img.shields.io/travis/”Marcus/RALocationKit.svg?style=flat)](https://travis-ci.org/”Marcus/RALocationKit)
[![Version](https://img.shields.io/cocoapods/v/RALocationKit.svg?style=flat)](http://cocoapods.org/pods/RALocationKit)
[![License](https://img.shields.io/cocoapods/l/RALocationKit.svg?style=flat)](http://cocoapods.org/pods/RALocationKit)
[![Platform](https://img.shields.io/cocoapods/p/RALocationKit.svg?style=flat)](http://cocoapods.org/pods/RALocationKit)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)

Get the location of the user in just a few lines of code. This CoreLocation wrapper makes your location handling a blast!
This framework makes your life easier when it comes to location-handling in your Swift application. It makes use of completion-block instead of delegate pattern, for a convenient and clean implementation.

#Installation
The framework require a minimum deployment target of iOS 8.3

##Manual
Simply copy files `LocationKit.swift`, `LocationKitClient.swift`, `LocationKitConvenience.swift`, `LocationKitErrorHandler.swift` to your Xcode project

##CocoaPods
RALocationKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RALocationKit"
```

and run `pod install`


#Getting started
##Initialise
To begin with, you have to initialise the LocationKit instance.
```swift
let locationKit = RALocationKit()
```

##Getting the CLLocation object
```swift
locationKit.getCurrentLocation { (location, error) -> Void in
    if let location = location {
        ....
    } else {
        ....
    }
}
```

#Requirements
* iOS 8.3+
* Xcode 6.1

# License
The MIT License (MIT)

Copyright (c) [2016] [RALocationKit]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

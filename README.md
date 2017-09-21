# Sprocket

[![CI Status](http://img.shields.io/travis/Wzxhaha/Sprocket.svg?style=flat)](https://travis-ci.org/Wzxhaha/Sprocket)
[![Version](https://img.shields.io/cocoapods/v/Sprocket.svg?style=flat)](http://cocoapods.org/pods/Sprocket)
[![License](https://img.shields.io/cocoapods/l/Sprocket.svg?style=flat)](http://cocoapods.org/pods/Sprocket)
[![Platform](https://img.shields.io/cocoapods/p/Sprocket.svg?style=flat)](http://cocoapods.org/pods/Sprocket)

State machine on Swift4.0

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
enum State: Int, Stateable  {
    case getUp
    case eat
    case sleep
}

let sprocket = Sprocket<State>(idle: .getUp)

sprocket.rules = [
    [.sleep] >>> .getUp,
    [.getUp] >>> .eat,
    [.eat]   >>> .sleep,
]

sprocket.before { (current, from) in }

sprocket.on { (current, from) in }

sprocket.after { (current, from) in }
```

## Installation

Sprocket is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Sprocket'
```

## License

Sprocket is available under the MIT license. See the LICENSE file for more info.

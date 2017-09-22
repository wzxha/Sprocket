# Sprocket

[![CI Status](http://img.shields.io/travis/Wzxhaha/Sprocket.svg?style=flat)](https://travis-ci.org/Wzxhaha/Sprocket)
[![Version](https://img.shields.io/cocoapods/v/Sprocket.svg?style=flat)](http://cocoapods.org/pods/Sprocket)
[![License](https://img.shields.io/cocoapods/l/Sprocket.svg?style=flat)](http://cocoapods.org/pods/Sprocket)
[![Platform](https://img.shields.io/cocoapods/p/Sprocket.svg?style=flat)](http://cocoapods.org/pods/Sprocket)

State machine on Swift4.0

## Use
1. Create an `Int` enumeration that abides on the `Stateable` protocol

```swift
enum State: Int, Stateable  {
    case getUp
    case eat
    case sleep
}
```

2. Use the enumeration to create a "Sprocket" and set its default state (idle)

```swift
let sprocket = Sprocket<State>(idle: .getUp)
```

3. Set its rules

```swift
sprocket.rules = [
    [.sleep] >>> .getUp,
    [.getUp] >>> .eat,
    [.eat]   >>> .sleep,
]
```

4. Set up its state listening

```swift
sprocket.before { (from, to) in }

sprocket.on { (from, to) in }

sprocket.after { (from, to) in }
```

you can listen to a single state also

```swift
sprocket.before(.getUp) { from in }

sprocket.on(.getUp) { from in }

sprocket.after(.getUp) { from in }
```

5. Use `func to:` to switch state

```swift
sprocket.to(.eat)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Sprocket is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Sprocket'
```

## License

Sprocket is available under the MIT license. See the LICENSE file for more info.

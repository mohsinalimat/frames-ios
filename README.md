# FramesIos

[![Build Status](https://travis-ci.org/checkout/frames-ios.svg?branch=master)](https://travis-ci.org/checkout/frames-ios)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Frames.svg)](https://img.shields.io/cocoapods/v/Frames)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/Frames.svg?style=flat)]()
[![codecov](https://codecov.io/gh/checkout/frames-ios/branch/master/graph/badge.svg)](https://codecov.io/gh/checkout/frames-ios)
[![codebeat badge](https://codebeat.co/badges/d9bae177-78c1-40bb-94a7-187a7759d549)](https://codebeat.co/projects/github-com-checkout-frames-ios-master)
![license](https://img.shields.io/github/license/checkout/frames-ios.svg)

<p align="center">
	<img src="https://github.com/checkout/frames-ios/blob/master/screenshots/demo-frames-ios.gif" width="320" alt="Demo frames ios"/>
</p>

## Requirements

- iOS 10.0+
- Xcode 9.0+
- Swift 4.1+

## Documentation

You can find the FramesIos documentation [on this website](https://checkout.github.io/frames-ios/index.html).

- [Usage](https://checkout.github.io/frames-ios/usage.html)
- [Customizing the card view](https://checkout.github.io/frames-ios/customizing-the-card-view.html)
- Walkthrough
  - [iOS Example Frames](https://checkout.github.io/frames-ios/ios-example-frames.html)
  - [iOS Example](https://checkout.github.io/frames-ios/ios-example.html)

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1+ is required to build FramesIos 1.0+.

To integrate FramesIos into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Frames', '~> 2.0'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate FramesIos into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "checkout/frames-ios" ~> 2.0
```

Run `carthage update` to build the framework and drag the built `FramesIos` into your Xcode project.

## Usage

Import the SDK:

```swift
import FramesIos
```

### Using `CardViewController`

```swift
class ViewController: UIViewController, CardViewControllerDelegate {

    let checkoutAPIClient = CheckoutAPIClient(publicKey: "pk_test_6ff46046-30af-41d9-bf58-929022d2cd14",
                                              environment: .sandbox)
    let cardViewController = CardViewController(cardHolderNameState: .hidden, billingDetailsState: .hidden)

    override func viewDidLoad() {
        super.viewDidLoad()
        // set the card view controller delegate
        cardViewController.delegate = self
        // replace the bar button by Pay
        cardViewController.rightBarButtonItem = UIBarButtonItem(title: "Pay", style: .done, target: nil, action: nil)
        // specified which schemes are allowed
        cardViewController.availableSchemes = [.visa, .mastercard]

        navigationController?.pushViewController(cardViewController, animated: false)
    }

    func onTapDone(card: CkoCardTokenRequest) {
        checkoutAPIClient.createCardToken(card: card, successHandler: { cardToken in
            print(cardToken.id)
        }, errorHandler: { error in
            print(error)
        })
    }

}
```

### Using Methods available in FramesIos

You can find more examples on the [usage guide](https://checkout.github.io/frames-ios/usage.html).

#### Create the API Client `CheckoutAPIClient`:

```swift
// replace "pk_test_6ff46046-30af-41d9-bf58-929022d2cd14" by your own public key
let checkoutAPIClient = CheckoutAPIClient(publicKey: "pk_test_6ff46046-30af-41d9-bf58-929022d2cd14",
                                          environment: .sandbox)
```

#### Create the `CardUtils` instance:

```swift
let cardUtils = CardUtils()
```

#### Use `CardUtils` to verify card number:

```swift
/// verify card number
let cardNumber = "4242424242424242"
let isCardValid = cardUtils.isValid(cardNumber: cardNumber)
```

#### Create the card token request `CardTokenRequest`:

```swift
// create the phone number
let phoneNumber = CkoPhoneNumber(countryCode:number:)
// create the address
let address = CkoAddress(name:addressLine1:addressLine2:city:state:postcode:country:phone:)
// create the card token request
let cardTokenRequest = CkoCardTokenRequest(number:expiryMonth:expiryYear:cvv:name:billingAddress:)
```

#### Create a card token:

```swift
let checkoutAPIClient = CheckoutAPIClient(publicKey: "pk_......", environment: .live)
// create the phone number
let phoneNumber = CkoPhoneNumber(countryCode:number:)
// create the address
let address = CkoAddress(name:addressLine1:addressLine2:city:state:postcode:country:phone:)
// create the card token request
let cardTokenRequest = CkoCardTokenRequest(number:expiryMonth:expiryYear:cvv:name:billingAddress:)
checkoutAPIClient.createCardToken(card: cardTokenRequest, successHandler: { cardTokenResponse in
    // success
}, errorHandler { error in
    // error
})
```

The success handler takes an array of `CkoCardTokenResponse` as a parameter.
The error handler takes an `ErrorResponse` as a parameter.

## License

FramesIos is released under the MIT license. [See LICENSE](https://github.com/checkout/frames-ios/blob/master/LICENSE) for details.

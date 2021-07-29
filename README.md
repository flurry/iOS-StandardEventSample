# iOS-StandardEventSample
This Sample app guide walks you through the steps of logging Flurry standardized event into your iOS app.

## Introduction

Like a custom event, a standard event also has a two-level structure. The highest level is the specific action, in this case the purchasing of an item. For this example, we are using the SDK standardized event name `FLURRY_EVENT_PURCHASED`.

In Flurry+Event.h, Flurry iOS SDK defines 58 standardized event names, and they are categorized in advertising, gaming, content, commerce, membership, onboarding, registration, search, social, media, and privacy. 

The second level in the standard event structure is the event parameter, which will be an instance of SDK defined Interface - FlurryParamBuilder. In order for SDK to log a standard event, you might want to put the standardized parameters as well as your own defined parameters together. There will be recommended standardized parameter keys and mandatory standardized parameter keys defined for each standard event name. For instance, to log FLURRY_EVENT_PURCHASED event name, SDK suggests to include itemCount, totalAmount, itemId, success, itemName, itemType, currencyType and transactionId parameters, in which totalAmount is also a mandatory parameter that is indicated by the SDK. There are more than 40 standardized parameter keys that come from 5 interfaces (FlurryStringParam, FlurryDoubleParam, FlurryBooleanParam, FlurryIntegerParam, FlurryLongParam). Each type of standardized parameter key can only be mapped to its corresponding data value - string, integer, double, boolean, long. So when you assemble your FlurryParamBuilder object with the standardized parameters, you will need to use the public APIs specified in FlurryParamBuilder interface to map them correctly.

## Integration of Flurry iOS SDK

If you already have a Flurry project for Analytics or Ads, you may skip these steps.

Set up your project using the instructions provided in
[Integrate Flurry SDK for iOS](https://developer.yahoo.com/flurry/docs/integrateflurry/ios/).

1. Create an App and Get Your API Key.
2. Add the following dependency to your app's [CocoaPod](https://cocoapods.org/), then do `pod install`.
```ruby
    pod 'Flurry-iOS-SDK/FlurrySDK' #Analytics Pod
    pod 'Flurry-iOS-SDK/FlurryAds' #Advertising Pod (requires Analytics)
```
3. Initialize the Flurry SDK with your project’s API key.
```objc
    [Flurry startSession:YOUR_FLURRY_API_KEY];
```

## Navigate Sample code

1. Initialize Flurry SDK

```objc
    [Flurry startSession:YOUR_FLURRY_API_KEY];
```
2. Create the FlurryParamBuilder instance (example)
```objc
    FlurryParamBuilder *param = [[[[[[FlurryParamBuilder alloc] init]
                                   setString:@"Game pro" forParam:[FlurryParamBuilder levelName]]
                                  setInteger:2 forParam:[FlurryParamBuilder levelNumber]]
                                   setString:@"12345" forKey:@"userId"]
                                  setInteger:10 forKey:@"numOfTrials"];
```
3. Log the event
```objc
    [Flurry logStandardEvent:FLURRY_EVENT_LEVEL_COMPLETED withParameters:param];
```

## Support

[Flurry Developer Support Site](https://developer.yahoo.com/flurry/docs/)








<img src="https://user-images.githubusercontent.com/93546810/183488926-e467537a-4895-460a-9535-2a0fd869bf28.png" alt="weatherly icon" width="200"/>

# Weatherly

## Description
Simple app that grabs phone location and displays current temperature and weather conditions.

## Skills Practiced

* UI Layout
* Autolayout and constraints
* Dark Mode
* Protocol/Delegate Pattern
* Closures/Completion Handlers
* Use APIs
* HTTP Requests
* JSON Encoding/Decoding
* Grand Central Dispatch
* Organizing Code via Extensions
* MVC Pattern
* Code Snippets
* Core Location

## Use Instructions

This app involves using an external API. To use the app, clone the project and add your own API key.

1. Create an account with [OpenWeather](https://openweathermap.org)
2. Copy your own API key
3. In the app project, create a Constants struct.
4. Store your API key in a type property of the Constants struct titled OpenWeatherAPIKey.

```swift
struct Constants {
  static let openWeatherAPIKey = "<enter your API key here>"
}
```

Now the app should function normally.

## Attributions

This was developed using ideas from The App Brewery's Complete App Development Bootcamp, check out the full course at [www.appbrewery.co](https://www.appbrewery.co/)

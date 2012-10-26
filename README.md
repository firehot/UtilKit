UtilKit 1.0
===========

A full ARC-based Utility Kit of functions useful to many iOS apps. UtilKit includes easy access to device information and support for the iPhone 5 four inch display as well as human-friendly dates. The functions are placed in categories for easy integration into your app.

While developing several iOS apps, I ended up creating a library of functions that every app needed to simplify development a little. UtilKit is these functions packaged into categories along with a tiny demo. I will continue to update UtilKit with new functions and categories as new devices are released and as I write and refactor code.

Before writing UtilKit, I found other projects that provided the same functionality but as a means to accomplish a greater project goal. So, it was difficult to find these methods in a small, reusable package. I have tried to keep classes uncorrelated, so that you can pick or choose which classes you'd like to use when. However, in the interests of quality and efficiency, some classes use methods in others (i.e., UIImage+Auto568h requires UIDevice+Attributes). As such, there isn't a library to link to, just add the files you want to your Xcode project and you're ready to use UtilKit.

UtilKit uses ARC and Objective-C literals introduced in Xcode 4.5 to produce high-quality code. However, most of the code doesn't make use of these features, so you may be able to use them without modification in older projects. UtilKit is open source software provided with the FreeBSD license.

UIDevice+Attributes
-------------------

A category that extends UIDevice with various methods to easily retrieve information about an iOS device including model type, four inch display detection, and MAC address. However, I would not recommend using the MAC address for device identification as Apple may remove access to such information at any time.

Add #import "UIDevice+Attributes.h" wherever needed or just once in your precompiled header file.

UIImage+Auto568h
----------------

A category that extends UIImage by replacing the imageNamed: method with one that automatically loads PNG files with '-568h' in their filename. This is the convention promoted by Apple and used for the splash screen. However, the OS ignores the '-568h' modifier on all images except the splash screen. So, in order to load an image specifically for an iPhone 5, you must make a specific call to imageNamed:.

UIImage+Auto568h solves this by first checking if the device has a four inch display, and if so, replacing the imageNamed: method with imageNamed568h:. On every call to imageNamed:, the method checks to see if an image with the '-568h' modifier exists, and if so, it will load the iPhone 5 image, otherwise the normal loading process occurs.

NSDate+Friendly
---------------

A category that extends NSDate to provide relative date calculations and "human-friendly" strings. The category contains simple methods for creating and comparing relative dates (e.g., yesterday, today and tomorrow) and times.

Known Issues
------------

Missing iPad mini and second generation iPad 4 model names in UIDevice+Attributes.


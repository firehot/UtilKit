//
//  UIDevice+Attributes.h
//  UtilKit
//
//  Copyright (c) 2012, Code of Intelligence, LLC
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of Code of Intelligence, LLC.
//

#import <UIKit/UIKit.h>

// Resolutions
#define SCREEN_WIDTH_IPHONE 320.0
#define SCREEN_HEIGHT_IPHONE 480.0
#define SCREEN_HEIGHT_IPHONE_5 568.0
#define SCREEN_HEIGHT_OFFSET_IPHONE_5 (SCREEN_HEIGHT_IPHONE_5 - SCREEN_HEIGHT_IPHONE)

#define SCREEN_WIDTH_IPAD 768.0
#define SCREEN_HEIGHT_IPAD 1024.0

// iPhone Names
#define STRING_DEVICE_IPHONE            @"iPhone"
#define STRING_DEVICE_IPHONE_1          @"iPhone 1"
#define STRING_DEVICE_IPHONE_3G         @"iPhone 3G"
#define STRING_DEVICE_IPHONE_3GS        @"iPhone 3GS"
#define STRING_DEVICE_IPHONE_4          @"iPhone 4"
#define STRING_DEVICE_IPHONE_4_VERIZON  @"iPhone 4 (Verizon)"
#define STRING_DEVICE_IPHONE_4S         @"iPhone 4S"
#define STRING_DEVICE_IPHONE_4S_GSM     @"iPhone 4S (GSM)"
#define STRING_DEVICE_IPHONE_4S_CDMA    @"iPhone 4S (CDMA)"
#define STRING_DEVICE_IPHONE_5          @"iPhone 5"
#define STRING_DEVICE_IPHONE_5_GSM      @"iPhone 5 (GSM)"
#define STRING_DEVICE_IPHONE_5_CDMA     @"iPhone 5 (CDMA)"
#define STRING_DEVICE_IPHONE_UNKNOWN    @"Unknown iPhone"

// iPod Touch Names
#define STRING_DEVICE_IPOD              @"iPod Touch"
#define STRING_DEVICE_IPOD_1G           @"iPod Touch 1G"
#define STRING_DEVICE_IPOD_2G           @"iPod Touch 2G"
#define STRING_DEVICE_IPOD_3G           @"iPod Touch 3G"
#define STRING_DEVICE_IPOD_4G           @"iPod Touch 4G"
#define STRING_DEVICE_IPOD_5G           @"iPod Touch 5G"
#define STRING_DEVICE_IPOD_UNKNOWN      @"Unknown iPod"

// iPad Names
#define STRING_DEVICE_IPAD              @"iPad"
#define STRING_DEVICE_IPAD_1            @"iPad 1"
#define STRING_DEVICE_IPAD_2            @"iPad 2"
#define STRING_DEVICE_IPAD_2_GSM        @"iPad 2 (GSM)"
#define STRING_DEVICE_IPAD_2_CDMA       @"iPad 2 (CDMA)"
#define STRING_DEVICE_IPAD_3            @"iPad 3"
#define STRING_DEVICE_IPAD_3_GSM        @"iPad 3 (GSM)"
#define STRING_DEVICE_IPAD_3_CDMA       @"iPad 3 (CDMA)"
#define STRING_DEVICE_IPAD_UNKNOWN      @"Unknown iPad"

// Apple TV Names
#define STRING_DEVICE_APPLETV           @"Apple TV"
#define STRING_DEVICE_APPLETV_2G        @"Apple TV 2G"
#define STRING_DEVICE_APPLETV_3G        @"Apple TV 3G"
#define STRING_DEVICE_APPLETV_UNKNOWN   @"Unknown Apple TV"

#define STRING_DEVICE_SIMULATOR         @"iOS Simulator"
#define STRING_DEVICE_SIMULATOR_IPHONE  @"iPhone Simulator"
#define STRING_DEVICE_SIMULATOR_IPAD    @"iPad Simulator"
#define STRING_DEVICE_SIMULATOR_APPLETV @"Apple TV Simulator"

#define STRING_DEVICE_IFPGA             @"iFPGA"

#define STRING_DEVICE_TYPE_UNKNOWN      @"Unknown iOS device"
#define STRING_DEVICE_UNKNOWN_IPHONE    @"Unknown iPhone"
#define STRING_DEVICE_UNKNOWN_IPOD      @"Unknown iPod"
#define STRING_DEVICE_UNKNOWN_IPAD      @"Unknown iPad"
#define STRING_DEVICE_UNKNOWN_TV        @"Unknown Apple TV"

typedef enum {
    UIDeviceModelUnknown,
    
    UIDeviceModelSimulator,
    UIDeviceModelSimulatorPhone,
    UIDeviceModelSimulatorPad,
    UIDeviceModelSimulatorAppleTV,
    
    UIDeviceModelPhone1,
    UIDeviceModelPhone3G,
    UIDeviceModelPhone3GS,
    UIDeviceModelPhone4,
    UIDeviceModelPhone4Verizon,
    UIDeviceModelPhone4SGSM,
    UIDeviceModelPhone4SCDMA,
    UIDeviceModelPhone5GSM,
    UIDeviceModelPhone5CDMA,
    
    UIDeviceModelPod1,
    UIDeviceModelPod2,
    UIDeviceModelPod3,
    UIDeviceModelPod4,
    UIDeviceModelPod5,
    
    UIDeviceModelPad1,
    UIDeviceModelPad2,
    UIDeviceModelPad2GSM,
    UIDeviceModelPad2CDMA,
    UIDeviceModelPad3,
    UIDeviceModelPad3GSM,
    UIDeviceModelPad3CDMA,
    
    UIDeviceModelAppleTV2,
    UIDeviceModelAppleTV3,
    
    UIDeviceModelPhoneUnkown,
    UIDeviceModelPodUnkown,
    UIDeviceModelPadUnkown,
    UIDeviceModelAppleTVUnknown,
    UIDeviceModelIFPGA
} UIDeviceModel;

typedef enum {
    UIDevicePlatformUnknown,
    
    UIDevicePlatformSimulator,
    UIDevicePlatformSimulatorPhone,
    UIDevicePlatformSimulatorPad,
    UIDevicePlatformSimulatorAppleTV,
    
    UIDevicePlatformPhone1,
    UIDevicePlatformPhone3G,
    UIDevicePlatformPhone3GS,
    UIDevicePlatformPhone4,
    UIDevicePlatformPhone4S,
    UIDevicePlatformPhone5,
    
    UIDevicePlatformPod1,
    UIDevicePlatformPod2,
    UIDevicePlatformPod3,
    UIDevicePlatformPod4,
    UIDevicePlatformPod5,
    
    UIDevicePlatformPad1,
    UIDevicePlatformPad2,
    UIDevicePlatformPad3,
    
    UIDevicePlatformAppleTV2,
    UIDevicePlatformAppleTV3,
    
    UIDevicePlatformPhoneUnkown,
    UIDevicePlatformPodUnkown,
    UIDevicePlatformPadUnkown,
    UIDevicePlatformAppleTVUnknown,
    UIDevicePlatformIFPGA
} UIDevicePlatform;

typedef enum {
    UIDeviceTypePhone,
    UIDeviceTypePod,
    UIDeviceTypePad,
    UIDeviceTypeAppleTV,
    UIDeviceTypeUnknown
} UIDeviceType;

@interface UIDevice (Attributes)

- (NSString *)hardwareModel;
- (NSString *)platform;
- (UIDeviceType)deviceType;
- (NSString *)deviceString;
- (UIDeviceModel)modelType;
- (NSString *)modelString;
- (UIDevicePlatform)platformType;
- (NSString *)platformString;

- (NSString *)macAddress;

- (bool)isPhone;
- (bool)isPad;
- (CGSize)screenSize;
- (CGFloat)screenWidth;
- (CGFloat)screenHeight;
- (bool)isPortrait;
- (bool)isLandscape;
- (bool)hasRetinaDisplay;
- (bool)hasFourInchDisplay;

@end

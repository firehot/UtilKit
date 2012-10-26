//
//  UIDevice+Attributes.m
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

//
// Platform determination orginally from https://gist.github.com/1323251
//
// Some enhancements found at https://github.com/erica/uidevice-extension
//      by Erica Sudan, et al. for iPhone Developer's Cookbook, 6.x edition
//

#import "UIDevice+Attributes.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

// sysctlbyname type specifiers
#define SYS_INFO_MODEL "hw.model"
#define SYS_INFO_MACHINE "hw.machine"

// iPhone machine names
#define MACHINE_IPHONE_1 @"iPhone1,1"
#define MACHINE_IPHONE_3G @"iPhone1,2"
#define MACHINE_IPHONE_3GS @"iPhone2,1"
#define MACHINE_IPHONE_4 @"iPhone3,1"
#define MACHINE_IPHONE_4_VERIZON @"iPhone3,3"
#define MACHINE_IPHONE_4S_GSM @"iPhone4,1"
#define MACHINE_IPHONE_4S_CDMA @"iPhone4,2"
#define MACHINE_IPHONE_5_GSM @"iPhone5,1"
#define MACHINE_IPHONE_5_CDMA @"iPhone5,2"

// iPod machine names
#define MACHINE_IPOD_1 @"iPod1,1"
#define MACHINE_IPOD_2 @"iPod2,1"
#define MACHINE_IPOD_3 @"iPod3,1"
#define MACHINE_IPOD_4 @"iPod4,1"
#define MACHINE_IPOD_4 @"iPod4,1"
#define MACHINE_IPOD_5 @"iPod5,1"

// iPad machine names
#define MACHINE_IPAD_1 @"iPad1,1"
#define MACHINE_IPAD_2 @"iPad2,1"
#define MACHINE_IPAD_2_GSM @"iPad2,2"
#define MACHINE_IPAD_2_CDMA @"iPad2,3"
#define MACHINE_IPAD_3 @"iPad3,1"
#define MACHINE_IPAD_3_GSM @"iPad3,2"
#define MACHINE_IPAD_3_CDMA @"iPad3,3"

// iFPGA machine name
#define MACHINE_IFPGA @"iFPGA"

// Machine name prefixes - used to detect models not defined above as well as platforms

// iPhone machine name prefixes
#define MACHINE_PREFIX_IPHONE @"iPhone"
#define MACHINE_PREFIX_IPHONE_3GS @"iPhone3"
#define MACHINE_PREFIX_IPHONE_4 @"iPhone3"
#define MACHINE_PREFIX_IPHONE_4S @"iPhone4"
#define MACHINE_PREFIX_IPHONE_5 @"iPhone5"

// iPod machine name prefixes
#define MACHINE_PREFIX_IPOD @"iPod"
#define MACHINE_PREFIX_IPOD_1 @"iPod1"
#define MACHINE_PREFIX_IPOD_2 @"iPod2"
#define MACHINE_PREFIX_IPOD_3 @"iPod3"
#define MACHINE_PREFIX_IPOD_4 @"iPod4"
#define MACHINE_PREFIX_IPOD_5 @"iPod5"

// iPad machine name prefixes
#define MACHINE_PREFIX_IPAD @"iPad"
#define MACHINE_PREFIX_IPAD_1 @"iPad1"
#define MACHINE_PREFIX_IPAD_2 @"iPad2"
#define MACHINE_PREFIX_IPAD_3 @"iPad3"

// Apple TV machine name prefixes
#define MACHINE_PREFIX_TV @"AppleTV"
#define MACHINE_PREFIX_TV_2 @"AppleTV2"
#define MACHINE_PREFIX_TV_3 @"AppleTV3"

// Simulator machine name prefixes
#define MACHINE_SUFFIX_SIM @"86"
#define MACHINE_PREFIX_SIM @"x86_64"

@implementation UIDevice (Attributes)

#pragma mark - sysctlbyname utils

- (NSString *)getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

#pragma mark - UIDevice+Attributes public methods

- (NSString *)hardwareModel
{
    return [self getSysInfoByName:SYS_INFO_MODEL];
}

- (NSString *)platform
{
    return [self getSysInfoByName:SYS_INFO_MACHINE];
}

// Returns the device type, e.g., iPhone, iPod, iPad or AppleTV
- (UIDeviceType)deviceType
{
    NSString *platform = [self platform];
    if ([platform hasPrefix:MACHINE_PREFIX_IPHONE]) return UIDeviceTypePhone;
    if ([platform hasPrefix:MACHINE_PREFIX_IPOD]) return UIDeviceTypePod;
    if ([platform hasPrefix:MACHINE_PREFIX_IPAD]) return UIDeviceTypePad;
    if ([platform hasPrefix:MACHINE_PREFIX_TV]) return UIDeviceTypeAppleTV;
    
    return UIDeviceTypeUnknown;
}

// Return a human-friendly string for the device type
- (NSString *)deviceString
{
    switch ([self deviceType])
    {
        case UIDeviceTypePhone: return STRING_DEVICE_IPHONE;
        case UIDeviceTypePod: return STRING_DEVICE_IPOD;
        case UIDeviceTypePad: return STRING_DEVICE_IPAD;
        case UIDeviceTypeAppleTV: return STRING_DEVICE_APPLETV;
            
        default: return STRING_DEVICE_TYPE_UNKNOWN;
    }
}

// Returns the device model type, e.g., iPad 3 (GSM)
- (UIDeviceModel)modelType
{
    NSString *platform = [self platform];
    
    // iPhone
    if ([platform isEqualToString:MACHINE_IPHONE_1]) return UIDeviceModelPhone1;
    if ([platform isEqualToString:MACHINE_IPHONE_3G]) return UIDeviceModelPhone3G;
    if ([platform isEqualToString:MACHINE_IPHONE_3GS]) return UIDeviceModelPhone3GS;
    if ([platform isEqualToString:MACHINE_IPHONE_4]) return UIDeviceModelPhone4;
    if ([platform isEqualToString:MACHINE_IPHONE_4_VERIZON]) return UIDeviceModelPhone4Verizon;
    if ([platform isEqualToString:MACHINE_IPHONE_4S_GSM]) return UIDeviceModelPhone4SGSM;
    if ([platform isEqualToString:MACHINE_IPHONE_4S_CDMA]) return UIDeviceModelPhone4SCDMA;
    if ([platform isEqualToString:MACHINE_IPHONE_5_GSM]) return UIDeviceModelPhone5GSM;
    if ([platform isEqualToString:MACHINE_IPHONE_5_CDMA]) return UIDeviceModelPhone5CDMA;
    
    // iPod
    if ([platform isEqualToString:MACHINE_IPOD_1]) return UIDeviceModelPod1;
    if ([platform isEqualToString:MACHINE_IPOD_2]) return UIDeviceModelPod2;
    if ([platform isEqualToString:MACHINE_IPOD_3]) return UIDeviceModelPod3;
    if ([platform isEqualToString:MACHINE_IPOD_4]) return UIDeviceModelPod4;
    if ([platform isEqualToString:MACHINE_IPOD_5]) return UIDeviceModelPod5;
    
    // iPad
    if ([platform isEqualToString:MACHINE_IPAD_1]) return UIDeviceModelPad1;
    if ([platform isEqualToString:MACHINE_IPAD_2]) return UIDeviceModelPad2;
    if ([platform isEqualToString:MACHINE_IPAD_2_GSM]) return UIDeviceModelPad2GSM;
    if ([platform isEqualToString:MACHINE_IPAD_2_CDMA]) return UIDeviceModelPad2CDMA;
    if ([platform isEqualToString:MACHINE_IPAD_3]) return UIDeviceModelPad3;
    if ([platform isEqualToString:MACHINE_IPAD_3_GSM]) return UIDeviceModelPad3GSM;
    if ([platform isEqualToString:MACHINE_IPAD_3_CDMA]) return UIDeviceModelPad3CDMA;
    
    // Apple TV
    if ([platform hasPrefix:MACHINE_PREFIX_TV_2]) return UIDeviceModelAppleTV2;
    if ([platform hasPrefix:MACHINE_PREFIX_TV_3]) return UIDeviceModelAppleTV3;
    
    if ([platform hasPrefix:MACHINE_PREFIX_IPHONE]) return UIDeviceModelPhoneUnkown;
    if ([platform hasPrefix:MACHINE_PREFIX_IPOD]) return UIDeviceModelPodUnkown;
    if ([platform hasPrefix:MACHINE_PREFIX_IPAD]) return UIDeviceModelPadUnkown;
    if ([platform hasPrefix:MACHINE_PREFIX_TV]) return UIDeviceModelAppleTVUnknown;
    
    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:MACHINE_SUFFIX_SIM] || [platform isEqual:MACHINE_PREFIX_SIM])
    {
        BOOL smallerScreen = [self screenWidth] < SCREEN_WIDTH_IPAD;
        return smallerScreen ? UIDeviceModelSimulatorPhone : UIDeviceModelSimulatorPad;
    }
    
    // The ever mysterious iFPGA - Erica Sudan
    if ([platform isEqualToString:MACHINE_IFPGA]) return UIDeviceModelIFPGA;
    
    return UIDeviceModelUnknown;
}

// Return a human-friendly string for the device model
- (NSString *)modelString
{
    switch ([self modelType])
    {
        case UIDeviceModelPhone1: return STRING_DEVICE_IPHONE_1;
        case UIDeviceModelPhone3G: return STRING_DEVICE_IPHONE_3G;
        case UIDeviceModelPhone3GS: return STRING_DEVICE_IPHONE_3GS;
        case UIDeviceModelPhone4: return STRING_DEVICE_IPHONE_4;
        case UIDeviceModelPhone4Verizon: return STRING_DEVICE_IPHONE_4_VERIZON;
        case UIDeviceModelPhone4SGSM: return STRING_DEVICE_IPHONE_4S_GSM;
        case UIDeviceModelPhone4SCDMA: return STRING_DEVICE_IPHONE_4S_CDMA;
        case UIDeviceModelPhone5GSM: return STRING_DEVICE_IPHONE_5_GSM;
        case UIDeviceModelPhone5CDMA: return STRING_DEVICE_IPHONE_5_CDMA;
        case UIDeviceModelPhoneUnkown: return STRING_DEVICE_UNKNOWN_IPHONE;
            
        case UIDeviceModelPod1: return STRING_DEVICE_IPOD_1G;
        case UIDeviceModelPod2: return STRING_DEVICE_IPOD_2G;
        case UIDeviceModelPod3: return STRING_DEVICE_IPOD_3G;
        case UIDeviceModelPod4: return STRING_DEVICE_IPOD_4G;
        case UIDeviceModelPod5: return STRING_DEVICE_IPOD_5G;
        case UIDeviceModelPodUnkown: return STRING_DEVICE_UNKNOWN_IPOD;
            
        case UIDeviceModelPad1: return STRING_DEVICE_IPAD_1;
        case UIDeviceModelPad2: return STRING_DEVICE_IPAD_2;
        case UIDeviceModelPad2GSM: return STRING_DEVICE_IPAD_2_GSM;
        case UIDeviceModelPad2CDMA: return STRING_DEVICE_IPAD_2_CDMA;
        case UIDeviceModelPad3: return STRING_DEVICE_IPAD_3;
        case UIDeviceModelPad3GSM: return STRING_DEVICE_IPAD_3_GSM;
        case UIDeviceModelPad3CDMA: return STRING_DEVICE_IPAD_3_CDMA;
        case UIDeviceModelPadUnkown: return STRING_DEVICE_UNKNOWN_IPAD;
            
        case UIDeviceModelAppleTV2: return STRING_DEVICE_APPLETV_2G;
        case UIDeviceModelAppleTV3: return STRING_DEVICE_APPLETV_3G;
        case UIDeviceModelAppleTVUnknown: return STRING_DEVICE_UNKNOWN_TV;
            
        case UIDeviceModelSimulator: return STRING_DEVICE_SIMULATOR;
        case UIDeviceModelSimulatorPhone: return STRING_DEVICE_SIMULATOR_IPHONE;
        case UIDeviceModelSimulatorPad: return STRING_DEVICE_SIMULATOR_IPAD;
        case UIDeviceModelSimulatorAppleTV: return STRING_DEVICE_SIMULATOR_APPLETV;
            
        case UIDeviceModelIFPGA: return STRING_DEVICE_IFPGA;
            
        default: return STRING_DEVICE_TYPE_UNKNOWN;
    }
}

// Returns the device platform type, e.g., iPad 3 with no further information
- (UIDevicePlatform)platformType
{
    NSString *platform = [self platform];
    
    // iPhone
    if ([platform isEqualToString:MACHINE_IPHONE_1]) return UIDevicePlatformPhone1;
    if ([platform isEqualToString:MACHINE_IPHONE_3G]) return UIDevicePlatformPhone3G;
    if ([platform hasPrefix:MACHINE_PREFIX_IPHONE_3GS]) return UIDevicePlatformPhone3GS;
    if ([platform hasPrefix:MACHINE_PREFIX_IPHONE_4]) return UIDevicePlatformPhone4;
    if ([platform hasPrefix:MACHINE_PREFIX_IPHONE_4S]) return UIDevicePlatformPhone4S;
    if ([platform hasPrefix:MACHINE_PREFIX_IPHONE_5]) return UIDevicePlatformPhone5;
    
    // iPod
    if ([platform hasPrefix:MACHINE_PREFIX_IPOD_1]) return UIDevicePlatformPod1;
    if ([platform hasPrefix:MACHINE_PREFIX_IPOD_2]) return UIDevicePlatformPod2;
    if ([platform hasPrefix:MACHINE_PREFIX_IPOD_3]) return UIDevicePlatformPod3;
    if ([platform hasPrefix:MACHINE_PREFIX_IPOD_4]) return UIDevicePlatformPod4;
    if ([platform hasPrefix:MACHINE_PREFIX_IPOD_5]) return UIDevicePlatformPod5;
    
    // iPad
    if ([platform hasPrefix:MACHINE_PREFIX_IPAD_1]) return UIDevicePlatformPad1;
    if ([platform hasPrefix:MACHINE_PREFIX_IPAD_2]) return UIDevicePlatformPad2;
    if ([platform hasPrefix:MACHINE_PREFIX_IPAD_3]) return UIDevicePlatformPad3;
    
    // Apple TV
    if ([platform hasPrefix:MACHINE_PREFIX_TV_2]) return UIDevicePlatformAppleTV2;
    if ([platform hasPrefix:MACHINE_PREFIX_TV_3]) return UIDevicePlatformAppleTV3;
    
    if ([platform hasPrefix:MACHINE_PREFIX_IPHONE]) return UIDevicePlatformPhoneUnkown;
    if ([platform hasPrefix:MACHINE_PREFIX_IPOD]) return UIDevicePlatformPodUnkown;
    if ([platform hasPrefix:MACHINE_PREFIX_IPAD]) return UIDevicePlatformPadUnkown;
    if ([platform hasPrefix:MACHINE_PREFIX_TV]) return UIDevicePlatformAppleTVUnknown;
    
    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:MACHINE_SUFFIX_SIM] || [platform isEqual:MACHINE_PREFIX_SIM])
    {
        BOOL smallerScreen = [self screenWidth] < SCREEN_WIDTH_IPAD;
        return smallerScreen ? UIDevicePlatformSimulatorPhone : UIDevicePlatformSimulatorPad;
    }
    
    // The ever mysterious iFPGA - Erica Sudan
    if ([platform isEqualToString:MACHINE_IFPGA]) return UIDevicePlatformIFPGA;
    
    return UIDevicePlatformUnknown;
}

// Return a human-friendly string for the device platform
- (NSString *)platformString
{
    switch ([self platformType])
    {
        case UIDevicePlatformPhone1: return STRING_DEVICE_IPHONE_1;
        case UIDevicePlatformPhone3G: return STRING_DEVICE_IPHONE_3G;
        case UIDevicePlatformPhone3GS: return STRING_DEVICE_IPHONE_3GS;
        case UIDevicePlatformPhone4: return STRING_DEVICE_IPHONE_4;
        case UIDevicePlatformPhone4S: return STRING_DEVICE_IPHONE_4S;
        case UIDevicePlatformPhone5: return STRING_DEVICE_IPHONE_5;
        case UIDevicePlatformPhoneUnkown: return STRING_DEVICE_UNKNOWN_IPHONE;
            
        case UIDevicePlatformPod1: return STRING_DEVICE_IPOD_1G;
        case UIDevicePlatformPod2: return STRING_DEVICE_IPOD_2G;
        case UIDevicePlatformPod3: return STRING_DEVICE_IPOD_3G;
        case UIDevicePlatformPod4: return STRING_DEVICE_IPOD_4G;
        case UIDevicePlatformPod5: return STRING_DEVICE_IPOD_5G;
        case UIDevicePlatformPodUnkown: return STRING_DEVICE_UNKNOWN_IPOD;
            
        case UIDevicePlatformPad1: return STRING_DEVICE_IPAD_1;
        case UIDevicePlatformPad2: return STRING_DEVICE_IPAD_2;
        case UIDevicePlatformPad3: return STRING_DEVICE_IPAD_3;
        case UIDevicePlatformPadUnkown: return STRING_DEVICE_UNKNOWN_IPAD;
            
        case UIDevicePlatformAppleTV2: return STRING_DEVICE_APPLETV_2G;
        case UIDevicePlatformAppleTV3: return STRING_DEVICE_APPLETV_3G;
        case UIDevicePlatformAppleTVUnknown: return STRING_DEVICE_UNKNOWN_TV;
            
        case UIDevicePlatformSimulator: return STRING_DEVICE_SIMULATOR;
        case UIDevicePlatformSimulatorPhone: return STRING_DEVICE_SIMULATOR_IPHONE;
        case UIDevicePlatformSimulatorPad: return STRING_DEVICE_SIMULATOR_IPAD;
        case UIDevicePlatformSimulatorAppleTV: return STRING_DEVICE_SIMULATOR_APPLETV;
            
        case UIDevicePlatformIFPGA: return STRING_DEVICE_IFPGA;
            
        default: return STRING_DEVICE_TYPE_UNKNOWN;
    }
}

// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
- (NSString *)macAddress
{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Error: Memory allocation error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2\n");
        free(buf); // Thanks, Remy "Psy" Demerest
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    free(buf);
    return outstring;
}

// Returns true if the device is an iPhone or iPod Touch
- (bool)isPhone
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

// Returns true if the device is an iPad or iPad-mini
- (bool)isPad
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

// Returns the current size of the screen
- (CGSize)screenSize
{
    if ([self isLandscape])
        return CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    return [UIScreen mainScreen].bounds.size;
}

// Returns the current screen width
- (CGFloat)screenWidth
{
    return [self screenSize].width;
}

// Returns the current screen height
- (CGFloat)screenHeight
{
    return [self screenSize].height;
}

// Returns true if the device is currently in portrait or if the orientation is not known
- (bool)isPortrait
{
    if (self.orientation == UIDeviceOrientationUnknown)
        return true;    // assume we're in portrait
    return UIDeviceOrientationIsPortrait(self.orientation);
}

// Returns true if the device is currently in landscape
- (bool)isLandscape
{
    return UIDeviceOrientationIsLandscape(self.orientation);
}

// Returns true if the device has a Retina display
- (bool)hasRetinaDisplay
{
    return ([UIScreen mainScreen].scale == 2.0f);
}

// Returns true if the device has a four inch display as found on the iPhone 5
- (bool)hasFourInchDisplay
{
    return ([self isPhone] && [UIScreen mainScreen].bounds.size.height == SCREEN_HEIGHT_IPHONE_5);
}

@end

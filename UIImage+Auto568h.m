//
//  UIImage+Auto568h.m
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

#import "UIImage+Auto568h.h"

#include <objc/runtime.h>

@implementation UIImage (Auto568h)

+ (void)load
{
    // If 4-inch display, replace imageNamed with imageNamed568h
    if  ([[UIDevice currentDevice] hasFourInchDisplay])
    {
        method_exchangeImplementations(class_getClassMethod(self, @selector(imageNamed:)),
                                       class_getClassMethod(self, @selector(imageNamed568h:)));
    }
}

+ (UIImage *)imageNamed568h:(NSString *)imageName
{
    // Create a string for the image filename including the '-568h' modifier to see if such an image exists
    NSMutableString *imageNameMutable = [imageName mutableCopy];
    
    // Remove the '.png' filename extension
    NSRange pngExt = [imageName rangeOfString:@".png" options:NSBackwardsSearch | NSAnchoredSearch];
    if (pngExt.location != NSNotFound)
        [imageNameMutable deleteCharactersInRange:pngExt];
    
    // Look for the '@2x' retina modifier to find location to insert the '-568h' modifier into filename
    NSRange retinaMod = [imageName rangeOfString:@"@2x"];
    if (retinaMod.location != NSNotFound)
        [imageNameMutable insertString:@"-568h" atIndex:retinaMod.location];
    else
        [imageNameMutable appendString:@"-568h@2x"];
    
    // Check if the 568h image exists and load if so, otherwise load the original filename
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageNameMutable ofType:@"png"];
    if (imagePath)
        return [UIImage imageNamed568h:imageNameMutable];
    else
        return [UIImage imageNamed568h:imageName];
}

@end

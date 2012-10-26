//
//  CiAppDelegate.h
//  UtilKitDemo
//
//  Created by Mark Lenz on 10/25/12.
//  Copyright (c) 2012 Mark Lenz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CiViewController;

@interface CiAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CiViewController *viewController;

@end

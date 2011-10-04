//
//  iONAppDelegate.h
//  iON
//
//  Created by justin on 11/10/2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBarController.h"
#import "CustomTabBarControllerDelegate.h"

@interface iONAppDelegate : NSObject <UIApplicationDelegate,CustomTabBarControllerDelegate>
{
	UIWindow* _window;
	CustomTabBarController* _customTabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) CustomTabBarController* customTabBarController;

@end

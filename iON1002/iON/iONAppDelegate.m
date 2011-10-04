//
//  iONAppDelegate.m
//  iON
//
//  Created by justin on 11/10/2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "iONAppDelegate.h"

@implementation iONAppDelegate

@synthesize window = _window;
@synthesize customTabBarController = _customTabBarController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect screenRect = CGRectMake(0, 0, _window.frame.size.width, _window.frame.size.height-20);
	_customTabBarController = [[CustomTabBarController alloc] initWithFrameAndImage:screenRect backgroundImageName:@"tab_background"];
	[_customTabBarController addTabBarItem:@"SDViewController" defaultImageName:@"SD_icon" selectedImageName:@"SD_icon" isSelected:TRUE];
	[_customTabBarController addTabBarItem:@"IONViewController" defaultImageName:@"ION_icon" selectedImageName:@"ION_icon" isSelected:FALSE];
	[_customTabBarController addTabBarItem:@"RemoteViewController" defaultImageName:@"Remote_icon" selectedImageName:@"Remote_icon" isSelected:FALSE];
	[_customTabBarController addTabBarItem:@"prefViewController" defaultImageName:@"Setting_icon" selectedImageName:@"Setting_icon" isSelected:FALSE];
    
	self.window.rootViewController = _customTabBarController;
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_customTabBarController release];
    [super dealloc];
}
#pragma mark - CustomTabBarControllerDelegate

- (void)tabBarController:(CustomTabBarController*)tabBarController didSelectViewController:(UIViewController*)viewContoller
{ 
}

- (BOOL)customTabBarController:(CustomTabBarController*)tabBarController shouldSelectViewController:(UIViewController*)viewContoller
{
	return TRUE;
}
@end

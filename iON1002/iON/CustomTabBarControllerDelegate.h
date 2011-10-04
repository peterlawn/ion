//
//  CustomTabBarControllerDelegate.h
//  ExampleCustomTabBar

#import <Foundation/Foundation.h>
@class CustomTabBarController;

@protocol CustomTabBarControllerDelegate <NSObject>

@optional
- (void) tabBarController:(CustomTabBarController*)tabBarController didSelectViewController:(UIViewController*)viewContoller;
- (BOOL) customTabBarController:(CustomTabBarController*)tabBarController shouldSelectViewController:(UIViewController*)viewContoller;

@end

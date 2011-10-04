//
//  CustomTabBarDelegate.h
//  ExampleCustomTabBar

#import <Foundation/Foundation.h>
@class CustomTabBar;
@class CustomTabBarItem;

@protocol CustomTabBarDelegate <NSObject>

@optional
- (void)customTabBar:(CustomTabBar*)tabBar didSelectItem:(CustomTabBarItem*)selectedItem;

@end

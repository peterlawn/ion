//
//  CustomTabBarItemDelegate.h
//  ExampleCustomTabBar

#import <Foundation/Foundation.h>
@class CustomTabBarItem;

@protocol CustomTabBarItemDelegate <NSObject>

@required
- (void)customTabBarItem:(CustomTabBarItem*)item isSelected:(BOOL)isSelected;

@end

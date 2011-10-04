//
//  CustomTabBarItem.h
//  ExampleCustomTabBar

#import <UIKit/UIKit.h>
#import "CustomTabBarItemDelegate.h"
@class CustomTabBar;

@interface CustomTabBarItem : NSObject
{
	UIButton* _button;
	int _index;
	BOOL _selected;
	id<CustomTabBarItemDelegate> _delegate;	
}

@property (nonatomic, readonly) CustomTabBar* tabBar;
@property (nonatomic, readonly) UIView* view;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, readonly) int index;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) id<CustomTabBarItemDelegate> delegate;

- (id)init:(int)index defaultImage:(UIImage*) defaultImage selectedImage:(UIImage*)selectedImage;

@end

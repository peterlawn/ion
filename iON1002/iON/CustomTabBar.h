//
//  CustomTabBar.h
//  ExampleCustomTabBar

#import <UIKit/UIKit.h>
#import "CustomTabBarItem.h"
#import "CustomTabBarDelegate.h"

@interface CustomTabBar : UIView <CustomTabBarItemDelegate>
{
	NSMutableArray* _items;
	CustomTabBarItem* _selectedItem;
	id<CustomTabBarDelegate> _delegate;
}

- (id)initWithImage:(UIImage*)image;
- (void)addItem:(UIImage*)defaultImage selectedImage:(UIImage*)selectedImage isSelected:(BOOL)isSelected;

@property (nonatomic, readonly) NSArray* items;
@property (nonatomic, readonly) CustomTabBarItem* selectedItem;
@property (nonatomic, assign) id<CustomTabBarDelegate> delegate;

@end

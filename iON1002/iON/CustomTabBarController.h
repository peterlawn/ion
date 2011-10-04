//
//  CustomTabBarController.h
//  ExampleCustomTabBar

#import <UIKit/UIKit.h>
#import "CustomTabBarItem.h"
#import "CustomTabBar.h"
#import "CustomTabBarDelegate.h"
#import "CustomTabBarControllerDelegate.h"

@interface CustomTabBarController : UIViewController <CustomTabBarDelegate>
{
	UIView* _contentView;
	CustomTabBar* _tabBar;
	NSMutableArray* _viewControllers;
	UIViewController* _selectedViewController;
	int _selectedIndex;
	id<CustomTabBarControllerDelegate> _delegate;
}

@property (nonatomic, readonly) CustomTabBar* tabBar;
@property (nonatomic, readonly) NSArray* viewControllers;
@property (nonatomic, readonly) UIViewController* selectedViewController;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, assign) id<CustomTabBarControllerDelegate> delegate;

- (id)initWithFrameAndImage:(CGRect)frame backgroundImageName:(NSString*)backgroundImageName;
- (void)addTabBarItem:(NSString*)viewControllerClassName defaultImageName:(NSString*) defaultImageName selectedImageName:(NSString*)selectedImageName isSelected:(BOOL)isSelected;

@end

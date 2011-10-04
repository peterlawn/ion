//
//  CustomTabBarItem.m
//  ExampleCustomTabBar

#import "CustomTabBarItem.h"

@implementation CustomTabBarItem

@dynamic tabBar;
@dynamic view;
@dynamic frame;
@synthesize index = _index;
@synthesize selected = _selected;
@synthesize delegate = _delegate;

- (id)init:(int)index defaultImage:(UIImage*)defaultImage selectedImage:(UIImage*)selectedImage
{
	self = [super init];
	if (self)
	{
		_button = [UIButton buttonWithType:UIButtonTypeCustom];
		[_button setImage:defaultImage forState:UIControlStateNormal];
		[_button setImage:selectedImage forState:UIControlStateSelected];
		[_button addTarget:self action:@selector(onTouchEnd:) forControlEvents:UIControlEventTouchUpInside];
        //[_button setBackgroundColor:[UIColor grayColor]];
        [_button setBackgroundImage:[UIImage imageNamed:@"button_bg.png"] forState:UIControlStateNormal];
        // [_button setBackgroundImage:[UIImage imageNamed:@"disabled.png"] forState:UIControlStateDisabled];
        [_button setBackgroundImage:[UIImage imageNamed:@"button_selected_bg.png"] 
                           forState:UIControlStateSelected];
       
		_index = index;
		_selected = false;
	}

	return self;
}

- (void)dealloc
{
	[_button release];
	
    [super dealloc];
}

- (CustomTabBar*)tabBar
{
	return (CustomTabBar*)_button.superview;
}

- (UIView*)view
{
	return _button;
}

- (CGRect)frame
{
	return _button.frame;
}

- (void)setFrame:(CGRect)frame
{
	_button.frame = frame;
}

- (void)setSelected:(BOOL)selected
{
	_selected = selected;
	[_button setSelected:_selected];
}

- (void)onTouchEnd:(UIButton*)control
{
	if (!_selected)
	{
		[self setSelected:TRUE];
		if (_delegate)
		{
			[_delegate customTabBarItem:self isSelected:TRUE];
		}
	}
}

@end

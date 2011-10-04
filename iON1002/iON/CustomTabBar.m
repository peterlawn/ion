//
//  CustomTabBar.m
//  ExampleCustomTabBar

#import "CustomTabBar.h"

@implementation CustomTabBar

@synthesize items = _items;
@synthesize selectedItem = _selectedItem;
@synthesize delegate = _delegate;

- (id)initWithImage:(UIImage*)image
{
	CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
	self = [super initWithFrame:frame];
	if (self)
	{
		_items = [[NSMutableArray alloc] init];
		_selectedItem = nil;
		_delegate = nil;

		UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:image];
		[self addSubview:backgroundImageView];
		
		[backgroundImageView release];
	}

	return self;
}

- (void)addItem:(UIImage*)defaultImage selectedImage:(UIImage*)selectedImage isSelected:(BOOL)isSelected
{
	int count = [_items count];

	CustomTabBarItem* item = [[CustomTabBarItem alloc] init:count defaultImage:defaultImage selectedImage:selectedImage];
	item.selected = isSelected;
	item.delegate = self;
	if (isSelected)
	{
		_selectedItem = item;
	}
	[_items addObject:item];
	[self addSubview:item.view];
	count++;

	int x = 0;
	int y = 0;
	int width = self.frame.size.width / count;
	int height = self.frame.size.height;
	for (CustomTabBarItem* resizeItem in _items)
	{
		resizeItem.frame = CGRectMake(x, y, width, height);
		x += width;
	}

	[item release];
}

- (void)dealloc
{
	[_items release];

	[super dealloc];
}

- (void)customTabBarItem:(CustomTabBarItem*)item isSelected:(BOOL)isSelected
{
	if (isSelected && _selectedItem != item)
	{
		if (_selectedItem)
		{
			[_selectedItem setSelected:FALSE];
		}

		_selectedItem = item;

		if (_delegate)
		{
			[_delegate customTabBar:self didSelectItem:_selectedItem];
		}
	}
}

@end

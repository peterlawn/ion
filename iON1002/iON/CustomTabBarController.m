//
//  CustomTabBarController.m
//  ExampleCustomTabBar

#import "CustomTabBarController.h"

@implementation CustomTabBarController

@synthesize tabBar = _tabBar;
@synthesize viewControllers = _viewControllers;
@synthesize selectedViewController = _selectedViewController;
@synthesize selectedIndex = _selectedIndex;
@synthesize delegate = _delegate;

- (id)initWithFrameAndImage:(CGRect)frame backgroundImageName:(NSString*)backgroundImageName
{
    self = [super init];
    if (self)
	{
		UIImage* backgroundImage = [UIImage imageNamed:backgroundImageName];

		_tabBar = [[CustomTabBar alloc] initWithImage:backgroundImage];
		_viewControllers = [[NSMutableArray alloc] init];
		_selectedViewController = nil;
		_selectedIndex = -1;
		_delegate = nil;

		UIView* mainView = [[UIView alloc] initWithFrame:frame];
		self.view = mainView;

		CGRect tabBarFrame = _tabBar.frame;
        //set tabBar frame
		_tabBar.frame = CGRectMake(0, 0, tabBarFrame.size.width, tabBarFrame.size.height);
		_tabBar.delegate = self;
        //set rootView  frame
		CGRect contentViewFrame = CGRectMake(0, tabBarFrame.size.height, frame.size.width, frame.size.height - tabBarFrame.size.height);
		_contentView = [[UIView alloc] initWithFrame:contentViewFrame];

		[self.view addSubview:_contentView];
		[self.view addSubview:_tabBar];

		[mainView release];
		[backgroundImage release];
    }

	return self;
}

- (void)dealloc
{
	[_contentView release];
	[_tabBar release];
	[_viewControllers release];

	[super dealloc];
}

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}

- (void)addTabBarItem:(NSString*)viewControllerClassName defaultImageName:(NSString*) defaultImageName selectedImageName:(NSString*)selectedImageName isSelected:(BOOL)isSelected
{
	int index = [_viewControllers count];
	id viewController = [[NSClassFromString(viewControllerClassName) alloc] init];
	[_viewControllers addObject:viewController];

	UIImage* defaultImage = [UIImage imageNamed:defaultImageName];
	UIImage* selectedImage = [UIImage imageNamed:selectedImageName];
	[_tabBar addItem:defaultImage selectedImage:selectedImage isSelected:isSelected];
	if (isSelected)
	{
		self.selectedIndex = index;
	}

	[viewController release];
	[defaultImage release];
	[selectedImage release];
}

- (void)setSelectedIndex:(int)selectedIndex
{
	if (_selectedViewController)
	{
		[_selectedViewController.view removeFromSuperview];
	}
	
	_selectedIndex = selectedIndex;
	_selectedViewController = [_viewControllers objectAtIndex:_selectedIndex];
	[_contentView addSubview:_selectedViewController.view];
}

#pragma mark - View lifecycle
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	[super viewDidLoad];
}
*/

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - CustomTabBarDelegate
- (void) customTabBar:(CustomTabBar*)tabBar didSelectItem:(CustomTabBarItem*)selectedItem;
{
	self.selectedIndex = selectedItem.index;
}

@end

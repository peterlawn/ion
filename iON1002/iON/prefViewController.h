//
//  prefViewController.h
//  pref
//
//  Created by peter on 11/10/1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface prefViewController : UIViewController
{
    sqlite3 *db;
    IBOutlet UIScrollView *prefScrollView;
    IBOutlet UITextField *fbAccount,*fbPassword;
    IBOutlet UITextField *youtubeAccount , *youtubePassword;
    IBOutlet UISwitch *lhdSwitch;
    
    
}
@property (nonatomic , retain) UITextField *fbAccount , *fbPassword , *youtubeAccount , *youtubePassword;
@property (nonatomic,retain)UISwitch *lhdSwitch;

-(IBAction)btnClicked:(id)sender;
-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)lhdSwitchChanged:(id)sender;
-(NSString *) filePath;

@end

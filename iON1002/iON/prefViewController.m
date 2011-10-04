//
//  prefViewController.m
//  pref
//
//  Created by peter on 11/10/1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "prefViewController.h"

@implementation prefViewController

@synthesize fbAccount,fbPassword,youtubeAccount,youtubePassword,lhdSwitch;

//generate databasefile function , 純回傳路徑用而已
-(NSString *) filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"database.sql"];
}

//從 filePath() 找路徑 ，並試著開啟檔案
-(void) openDB {
    if (sqlite3_open([[self filePath] UTF8String], &db)!= SQLITE_OK)
    {
        sqlite3_close(db);
        NSAssert(0, @"Database failed to open");
    }
    NSLog(@"databse setup *****");
}

//create table ,
- (void) createTableNamed:(NSString *) tableName
               withField1:(NSString *) field1
               withField2:(NSString *) field2
               withfield3:(NSString *) field3{
    char *err;
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' TEXT PRIMARY KEY, '%@' TEXT , '%@' TEXT);", 
                     tableName , field1 , field2 , field3];
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK)
    {
        sqlite3_close(db);
        NSAssert(0, @"Table failed to create");
    };
    NSLog(@"create table ok.");
}


- (void) insertRecordIntoTableNamed:(NSString *) tableName
                         withfiled1:(NSString *) field1
                         fieldValue:(NSString *) field1Value
                          andField2:(NSString *) field2
                         field2Value:(NSString *)field2Value 
                          andfield3:(NSString *) field3
                         field3Value:(NSString *)field3Value
{
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT OR REPLACE INTO '%@' ('%@' , '%@' , '%@')VALUES (? , ? , ?)",tableName , field1 , field2 , field3];
    
    const char *sql = [sqlStr UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK )
    {
        sqlite3_bind_text(statement, 1, [field1Value UTF8String], -1, NULL);
        sqlite3_bind_text(statement, 2, [field2Value UTF8String], -1, NULL);
        sqlite3_bind_text(statement, 3, [field3Value UTF8String], -1, NULL);
    }
    
    if (sqlite3_step(statement) != SQLITE_DONE)
    {
        NSAssert(0, @"Error updating table");
        
        sqlite3_finalize(statement);
    }
    
    NSLog(@"insert record");
}

//取出所有的row , 若是facebook和youtube column裡有值，直接放進uitextfield.
-(void) getAllRowsFromTableNamed: (NSString *) tableName {
    NSString *qsql = [NSString stringWithFormat:@"SELECT * FROM %@" , tableName];
    
    sqlite3_stmt *statement;
    NSLog(@"getall rows");
    
    if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSLog(@"\nrow\n");
            
            char *field1 = (char *) sqlite3_column_text(statement, 0);
            NSString *field1Str = [[NSString alloc] initWithUTF8String:field1];
            
            char *field2 = (char *) sqlite3_column_text(statement, 1);
            NSString *field2Str = [[NSString alloc] initWithUTF8String:field2];
            
            char *field3 = (char *) sqlite3_column_text(statement, 2);
            NSString *field3Str = [[NSString alloc] initWithUTF8String:field3];
            
            NSString *str = [[NSString alloc] initWithFormat:@"%@ - %@ - %@" , field1Str , field2Str , field3Str];
            
            NSLog(@"%@" , str);
            
            //若有回傳值，就放入uitextfield
            if ([field1Str isEqualToString:@"facebook"]) {
                [fbAccount setText:field2Str];
                [fbPassword setText:field3Str];
            }
            
            if ([field1Str isEqualToString:@"youtube"]) {
                [youtubeAccount setText:field2Str];
                [youtubePassword setText:field3Str];
            }
            
            [field1Str release];
            [field2Str release];
            [str release];
        }
        
        sqlite3_finalize(statement);
    }
}



//save button click事件
-(IBAction)btnClicked:(id)sender
{
    NSString *fb_id = [[NSString alloc] initWithFormat:@"%@" , fbAccount.text];
    NSString *fb_pw = [[NSString alloc] initWithFormat:@"%@" , fbPassword.text];
    NSString *yt_id = [[NSString alloc] initWithFormat:@"%@" , youtubeAccount.text];
    NSString *yt_pw = [[NSString alloc] initWithFormat:@"%@" , youtubePassword.text];
    
    //for debug
    NSLog(@"FB ID : %@" , fbAccount.text);
    NSLog(@"FB PS : %@" , fbPassword.text);
    NSLog(@"YT ID : %@" , youtubeAccount.text);
    NSLog(@"YT PS : %@" , youtubePassword.text);
    
    //insert facebook帳密至資料庫
    [self insertRecordIntoTableNamed:@"Account" withfiled1:@"type" fieldValue:@"facebook" andField2:@"id" field2Value:fb_id andfield3:@"pw" field3Value:fb_pw];
    //insert youtube帳密至資料庫
    [self insertRecordIntoTableNamed:@"Account" withfiled1:@"type" fieldValue:@"youtube" andField2:@"id" field2Value:yt_id andfield3:@"pw" field3Value:yt_pw];
    
    [self getAllRowsFromTableNamed:@"Account"];
    
    [fb_id release];
    [fb_pw release];
    [yt_id release];
    [yt_pw release];
    
}
//switch changed event.
-(IBAction) lhdSwitchChanged:(id)sender{
    if(![lhdSwitch isOn])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL message:@"It will take longer time to transfer the files to your smart devices." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        [alert release];
    }
}
//關閉鍵盤
-(IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [self openDB]; //開啟資料庫
    [self createTableNamed:@"Account" withField1:@"type" withField2:@"id" withfield3:@"pw"]; //建一個table
    [self getAllRowsFromTableNamed:@"Account"];//取回所有rows
    
    [super viewDidLoad];
    [prefScrollView setScrollEnabled:YES];
    [prefScrollView setContentSize:CGSizeMake(320, 800)];
}


- (void)viewDidUnload
{
    
    [super viewDidUnload];
    sqlite3_close(db); //關閉資料庫
    self.fbAccount=nil;
    self.fbPassword=nil;
    self.youtubeAccount=nil;
    self.youtubePassword=nil;
    self.lhdSwitch=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

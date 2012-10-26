//
//  UtilKitDemoViewController.m
//  UtilKitDemo
//
//  Copyright (c) 2012, Code of Intelligence, LLC
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of Code of Intelligence, LLC.
//

#import "UtilKitDemoViewController.h"

// UtilKit Friendly Dates
#import "NSDate+Friendly.h"

#define SECTION_DEVICE 0
#define ROW_HW_MODEL 0
#define ROW_TYPE 1
#define ROW_PLATFORM 2
#define ROW_MODEL 3
#define ROW_MODEL_ID 4
#define ROW_MAC_ADDRESS 5
#define ROW_PORTRAIT 6
#define ROW_LANDSCAPE 7
#define ROW_SCREEN_WIDTH 8
#define ROW_SCREEN_HEIGHT 9
#define ROW_RETINA 10
#define ROW_FOUR_INCH_DISPLAY 11

#define SECTION_DATE 1
#define ROW_YESTERDAY 0
#define ROW_YESTERDAY_FRIENDLY 1
#define ROW_TOMORROW 2
#define ROW_TOMORROW_FRIENDLY 3
#define ROW_TIME 4

@interface UtilKitDemoViewController ()

- (void)updateTime;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDate *startDate;

@end

@implementation UtilKitDemoViewController

- (void)updateTime
{
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:ROW_TIME inSection:SECTION_DATE]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // background shows "iPhone 5" in top right corner if running on a device with a four inch display by using UIImage+Auto568h to automatically load the correct file, but isn't made to look so well in landscape
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    self.startDate = [NSDate date];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.tableView reloadRowsAtIndexPaths:@[
                        [NSIndexPath indexPathForRow:ROW_PORTRAIT inSection:SECTION_DEVICE],
                         [NSIndexPath indexPathForRow:ROW_LANDSCAPE inSection:SECTION_DEVICE],
                         [NSIndexPath indexPathForRow:ROW_SCREEN_WIDTH inSection:SECTION_DEVICE],
                         [NSIndexPath indexPathForRow:ROW_SCREEN_HEIGHT inSection:SECTION_DEVICE]
                     ] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == SECTION_DEVICE)
        return @"Device";
    return @"Date";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case SECTION_DEVICE:
            return 12;
            break;
        case SECTION_DATE:
            return 5;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    
    switch (indexPath.section)
    {
        case SECTION_DEVICE:
            switch (indexPath.row)
            {
                case ROW_HW_MODEL:
                    cell.textLabel.text = @"Hardware Model";
                    cell.detailTextLabel.text = [[UIDevice currentDevice] hardwareModel];
                    break;
                case ROW_TYPE:
                    cell.textLabel.text = @"Type";
                    cell.detailTextLabel.text = ([[UIDevice currentDevice] isPhone] ? @"iPhone" : @"iPad");
                    break;
                case ROW_PLATFORM:
                    cell.textLabel.text = @"Platform";
                    cell.detailTextLabel.text = [[UIDevice currentDevice] platformString];
                    break;
                case ROW_MODEL:
                    cell.textLabel.text = @"Model";
                    cell.detailTextLabel.text = [[UIDevice currentDevice] modelString];
                    break;
                case ROW_MODEL_ID:
                    cell.textLabel.text = @"Model ID";
                    cell.detailTextLabel.text = [[UIDevice currentDevice] platform];
                    break;
                case ROW_MAC_ADDRESS:
                    cell.textLabel.text = @"MAC Address";
                    cell.detailTextLabel.text = [[UIDevice currentDevice] macAddress];
                    break;
                case ROW_PORTRAIT:
                    cell.textLabel.text = @"Portrait";
                    cell.detailTextLabel.text = ([[UIDevice currentDevice] isPortrait] ? @"Yes" : @"No");
                    break;
                case ROW_LANDSCAPE:
                    cell.textLabel.text = @"Landscape";
                    cell.detailTextLabel.text = ([[UIDevice currentDevice] isLandscape] ? @"Yes" : @"No");
                    break;
                case ROW_SCREEN_WIDTH:
                    cell.textLabel.text = @"Screen Width";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", (NSInteger)[[UIDevice currentDevice] screenWidth]];
                    break;
                case ROW_SCREEN_HEIGHT:
                    cell.textLabel.text = @"Screen Height";
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", (NSInteger)[[UIDevice currentDevice] screenHeight]];
                    break;
                case ROW_RETINA:
                    cell.textLabel.text = @"Retina Display";
                    cell.detailTextLabel.text = ([[UIDevice currentDevice] hasRetinaDisplay] ? @"Yes" : @"No");
                    break;
                case ROW_FOUR_INCH_DISPLAY:
                    cell.textLabel.text = @"4\" Display";
                    cell.detailTextLabel.text = ([[UIDevice currentDevice] hasFourInchDisplay] ? @"Yes" : @"No");
                    break;
            }
            break;
        case SECTION_DATE:
            switch (indexPath.row)
            {
                case ROW_YESTERDAY:
                    cell.textLabel.text = @"Yesterday";
                    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:[NSDate yesterday]];
                    break;
                case ROW_YESTERDAY_FRIENDLY:
                    cell.textLabel.text = @"Yesterday Friendly";
                    cell.detailTextLabel.text = [[NSDate yesterday] friendlyString:nil];
                    break;
                case ROW_TOMORROW:
                    cell.textLabel.text = @"Tomorrow";
                    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:[NSDate tomorrow]];
                    break;
                case ROW_TOMORROW_FRIENDLY:
                    cell.textLabel.text = @"Tomorrow Friendly";
                    cell.detailTextLabel.text = [[NSDate tomorrow] friendlyString:nil];
                    break;
                case ROW_TIME:
                    cell.textLabel.text = @"Started";
                    cell.detailTextLabel.text = [self.startDate friendlyString:nil];
                    break;
            }
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end

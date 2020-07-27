#import "TC5SettingViewController.h"
#import <Social/Social.h>
// #import "IonIcons.h"
#import "QBFlatButton.h"
#import "UINib+UIKit.h"
#import "TC5PhraseSectionTableViewCell.h"
#import "TC5SettingSoundTableViewCell.h"
#import "TC5SettingLicenceTableViewCell.h"


#pragma mark - TC5SettingViewController
@implementation TC5SettingViewController


#pragma mark - synthesize
@synthesize tableView;
@synthesize closeBarButtonItem;
@synthesize cellClasses;
@synthesize cellTitles;



#pragma mark - release
- (void)dealloc
{
    self.cellClasses = nil;
    self.cellTitles = nil;
}


#pragma mark - life cycle
- (void)loadView
{
    [super loadView];

    self.title = @"Setting";

    // barbuttonItem
    // [self.closeBarButtonItem setImage:[IonIcons imageWithIcon:icon_ios7_close_empty size:40 color:[UIColor whiteColor]]];
    [self.closeBarButtonItem setImage:[[UIImage systemImageNamed:@"xmark" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:40]] imageWithTintColor:[UIColor whiteColor]]];
    [self.closeBarButtonItem setImageInsets:UIEdgeInsetsMake(-4, -6, -4, 6)];


    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook] &&
        [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {

        self.cellClasses = @[
            [TC5PhraseSectionTableViewCell class],
            [TC5SettingSoundTableViewCell class],
            [TC5PhraseSectionTableViewCell class],
            [TC5SettingSocialTableViewCell class],
            [TC5SettingSocialTableViewCell class],
            [TC5SettingSocialTableViewCell class],
            [TC5PhraseSectionTableViewCell class],
            [TC5SettingLicenceTableViewCell class],
        ];
        self.cellTitles = @[
            @"Sound Setting",
            @"",
            @"Social",
            @"Tweet",
            @"Post",
            @"Review",
            @"Licence",
            @"",
        ];

    }
    else if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {

        self.cellClasses = @[
            [TC5PhraseSectionTableViewCell class],
            [TC5SettingSoundTableViewCell class],
            [TC5PhraseSectionTableViewCell class],
            [TC5SettingSocialTableViewCell class],
            [TC5SettingSocialTableViewCell class],
            [TC5PhraseSectionTableViewCell class],
            [TC5SettingLicenceTableViewCell class],
        ];
        self.cellTitles = @[
            @"Sound Setting",
            @"",
            @"Social",
            @"Post",
            @"Review",
            @"Licence",
            @"",
        ];

    }
    else if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {

        self.cellClasses = @[
            [TC5PhraseSectionTableViewCell class],
            [TC5SettingSoundTableViewCell class],
            [TC5PhraseSectionTableViewCell class],
            [TC5SettingSocialTableViewCell class],
            [TC5SettingSocialTableViewCell class],
            [TC5PhraseSectionTableViewCell class],
            [TC5SettingLicenceTableViewCell class],
        ];
        self.cellTitles = @[
            @"Sound Setting",
            @"",
            @"Social",
            @"Tweet",
            @"Review",
            @"Licence",
            @"",
        ];

    }
    else {

        self.cellClasses = @[
            [TC5PhraseSectionTableViewCell class],
            [TC5SettingSoundTableViewCell class],
            [TC5PhraseSectionTableViewCell class],
            [TC5SettingSocialTableViewCell class],
            [TC5PhraseSectionTableViewCell class],
            [TC5SettingLicenceTableViewCell class],
        ];
        self.cellTitles = @[
            @"Sound Setting",
            @"",
            @"Social",
            @"Review",
            @"Licence",
            @"",
        ];

    }
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.cellClasses.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellClasses[indexPath.row] TC5Height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = NSStringFromClass(self.cellClasses[indexPath.row]);
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:className];
    NSString *text = self.cellTitles[indexPath.row];

    if (!cell) {
        cell = (UITableViewCell *)[UINib UIKitFromClass:self.cellClasses[indexPath.row]];
    }

    if ([className isEqualToString:NSStringFromClass([TC5PhraseSectionTableViewCell class])]) {
        [[((TC5PhraseSectionTableViewCell *)cell) sectionLabel] setText:text];
    }
    else if ([className isEqualToString:NSStringFromClass([TC5SettingSocialTableViewCell class])]) {
        [((TC5SettingSocialTableViewCell *)cell) setTitleWithTitleString:text];
        [((TC5SettingSocialTableViewCell *)cell) setDelegate:self];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = NSStringFromClass(self.cellClasses[indexPath.row]);
    if ([className isEqualToString:NSStringFromClass([TC5SettingLicenceTableViewCell class])]) {
        [self performSegueWithIdentifier:kSeguePushTC5LicenseViewController
                                  sender:nil];
    }
    [self.tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}


#pragma mark - TC5SettingSocialTableViewCellDelegate
- (void)presentViewController:(UIViewController *)vc
                         cell:(TC5SettingSocialTableViewCell *)cell
{
    [self presentViewController:vc
                       animated:YES
                     completion:nil];
}


#pragma mark - event listener
- (IBAction)touchedUpInsideWithBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationController dismissViewControllerAnimated:YES
                                                  completion:^ () {}];
}


#pragma mark - private api


@end

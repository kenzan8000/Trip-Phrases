#import "TC5SettingSocialTableViewCell.h"


#pragma mark - TC5SettingViewController
@interface TC5SettingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, TC5SettingSocialTableViewCellDelegate> {
}


#pragma mark - property
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *closeBarButtonItem;
@property (nonatomic, strong) NSArray *cellClasses;
@property (nonatomic, strong) NSArray *cellTitles;


#pragma mark - event listener
- (IBAction)touchedUpInsideWithBarButtonItem:(UIBarButtonItem *)barButtonItem;


@end

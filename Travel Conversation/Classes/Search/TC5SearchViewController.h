#import "TC5LaunguageTableViewCell.h"


#pragma mark - class
//@class TC5Tutorial;


#pragma mark - TC5SearchViewController
@interface TC5SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,/* UISearchDisplayDelegate,*/ TC5LaunguageTableViewCellDelegate> {
}


#pragma mark - property
//@property (nonatomic, strong) TC5Tutorial *tutorial;
@property (nonatomic, weak) IBOutlet UITableView *menuTableView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *settingBarButtonItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *searchBarButtonItem;
@property (nonatomic, strong) NSMutableArray *cellClasses;
@property (nonatomic, strong) NSArray *searchCategories;
@property (nonatomic, strong) NSArray *searchResults;


#pragma mark - event listener
- (IBAction)touchedUpInsideWithBarButtonItem:(UIBarButtonItem *)barButtonItem;


@end

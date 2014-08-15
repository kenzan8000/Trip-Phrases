#pragma mark - TC5ChooseLanguageViewController
@interface TC5ChooseLanguageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
}


#pragma mark - property
@property (nonatomic, strong) NSMutableArray *languages;
@property (nonatomic, strong) NSString *notificationName;
@property (nonatomic, assign) NSInteger selectedIndexPathRow;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *closeBarButtonItem;


#pragma mark - event listener
- (IBAction)touchedUpInsideWithBarButtonItem:(UIBarButtonItem *)barButtonItem;


@end

#pragma mark - TC5ConversationCatalogViewController
@interface TC5ConversationCatalogViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
}


#pragma mark - property
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *conversations;


#pragma mark - event listener
- (IBAction)touchedUpInsideWithBarButtonItem:(UIBarButtonItem *)barButtonItem;


@end

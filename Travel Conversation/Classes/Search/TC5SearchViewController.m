#import "TC5SearchViewController.h"
#import "IonIcons.h"
#import "UINib+UIKit.h"
#import "UIColor+Hexadecimal.h"
#import "TC5PhraseSectionTableViewCell.h"
#import "TC5PhraseTableViewCellOdd.h"
#import "TC5PhraseTableViewCellEven.h"
#import "TC5ConversationCatalogTableViewCell.h"
#import "TC5ConversationCatalogViewController.h"
#import "TC5ChooseLanguageViewController.h"
#import "TC5ConversationViewController.h"
//#import "TC5Tutorial.h"
#import "TC5ConversationList.h"
#import "TC5CategoryList.h"
#import "TC5LocalizationList.h"
#import "TC5Conversation.h"
#import "TC5Category.h"
#import "TC5SearchCategory.h"


#pragma mark - TC5SearchViewController
@implementation TC5SearchViewController


#pragma mark - synthesize
//@synthesize tutorial;
@synthesize menuTableView;
@synthesize settingBarButtonItem;
@synthesize searchBarButtonItem;
@synthesize cellClasses;
@synthesize searchCategories;
@synthesize searchResults;


#pragma mark - release
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

//    self.tutorial = nil;
    self.cellClasses = nil;
    self.searchCategories = nil;
    self.searchResults = nil;
}


#pragma mark - life cycle
- (void)loadView
{
    [super loadView];

    self.title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];

    // tutorial
    //self.tutorial = [[TC5Tutorial alloc] initWithParentView:self.navigationController.view];

    // category
    NSInteger count = [[[TC5CategoryList sharedInstance] categories] count];
    NSMutableArray *categories = [NSMutableArray new];
    for (NSInteger i = 0; i < count; i++) {
        TC5SearchCategory *searchCategory = [TC5SearchCategory new];
        searchCategory.category = [[TC5CategoryList sharedInstance] categories][i];
        searchCategory.conversations = [[TC5ConversationList sharedInstance] conversationsWithCategory:searchCategory.category.enUS];
        [categories addObject:searchCategory];
    }
    self.searchCategories = [categories sortedArrayUsingComparator:^ NSComparisonResult(TC5SearchCategory *obj1, TC5SearchCategory *obj2) {
        return (obj1.conversations.count < obj2.conversations.count) ? NSOrderedDescending : NSOrderedAscending;
    }];

    // cell
    self.cellClasses = [NSMutableArray arrayWithArray:@[
        [TC5LaunguageTableViewCell class],
        [TC5PhraseSectionTableViewCell class],
    ]];
    for (NSInteger i = 0; i < count; i++) {
        id cellClass = (i % 2 == 0) ? [TC5PhraseTableViewCellEven class] : [TC5PhraseTableViewCellOdd class];
        [self.cellClasses addObject:cellClass];
    }

    // barbuttonItem
    [self.settingBarButtonItem setImage:[IonIcons imageWithIcon:icon_gear_a size:32 color:[UIColor whiteColor]]];
    [self.settingBarButtonItem setImageInsets:UIEdgeInsetsMake(-4, -6, -4, 6)];
    [self.searchBarButtonItem setImage:[IonIcons imageWithIcon:icon_ios7_search_strong size:32 color:[UIColor whiteColor]]];
    [self.searchBarButtonItem setImageInsets:UIEdgeInsetsMake(-4, -6, -4, 6)];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(nativeLanguageDidChoosedWithNotification:)
                                                 name:kNotificationChoosedNativeLanguage
                                               object:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    UIViewController *vc = [segue destinationViewController];

    // modal
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UIViewController *viewController = ((UINavigationController *)vc).viewControllers[0];
        if ([viewController isKindOfClass:[TC5ChooseLanguageViewController class]]) {
            TC5ChooseLanguageViewController *chooseLanguageViewController = (TC5ChooseLanguageViewController *)viewController;
            chooseLanguageViewController.notificationName = sender;
            if ([sender isEqualToString:kNotificationChoosedNativeLanguage]) {
                chooseLanguageViewController.title = [[TC5LocalizationList sharedInstance] localizationWithEnglishKey:@"Native Language"];
            }
            else {
                chooseLanguageViewController.title = [[TC5LocalizationList sharedInstance] localizationWithEnglishKey:@"Foreign language"];
            }
        }
    }
    else if ([vc isKindOfClass:[TC5ConversationCatalogViewController class]]) {
        NSInteger index = [[self.menuTableView indexPathForSelectedRow] row]-2;
        TC5ConversationCatalogViewController *viewController = (TC5ConversationCatalogViewController *)vc;
        viewController.conversations = [self.searchCategories[index] conversations];
        viewController.title = [self.searchCategories[index] categoryName];
    }

    [self.menuTableView deselectRowAtIndexPath:[self.menuTableView indexPathForSelectedRow]
                                      animated:YES];
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv
 numberOfRowsInSection:(NSInteger)section
{
    if (tv == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }

    return self.cellClasses.count;
}

- (CGFloat)tableView:(UITableView *)tv
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tv == self.searchDisplayController.searchResultsTableView) {
        TC5Conversation *conversation = self.searchResults[indexPath.row];
        NSString *text = [conversation nativeTitleText];
        return [TC5ConversationCatalogTableViewCell estimatedHeight:[UIFont systemFontOfSize:17]
                                                               text:text
                                                               size:CGSizeMake(tv.frame.size.width-80/*240*/, MAXFLOAT)];
    }

    return [self.cellClasses[indexPath.row] TC5Height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.menuTableView dequeueReusableCellWithIdentifier:NSStringFromClass([TC5SearchViewController class])];

    if (tableView == self.menuTableView) {

    if (!cell) {
        cell = (UITableViewCell *)[UINib UIKitFromClass:self.cellClasses[indexPath.row]];
    }

    if ([NSStringFromClass(self.cellClasses[indexPath.row]) isEqualToString:NSStringFromClass([TC5LaunguageTableViewCell class])]) {
        ((TC5LaunguageTableViewCell *)cell).delegate = self;
        [[((TC5LaunguageTableViewCell *)cell) fromButton] setImageEdgeInsets:UIEdgeInsetsMake(10.0, (self.view.frame.size.width-320)/4+40.0, 34.0, (self.view.frame.size.width-320)/4+40.0)];
        [[((TC5LaunguageTableViewCell *)cell) toButton] setImageEdgeInsets:UIEdgeInsetsMake(10.0, (self.view.frame.size.width-320)/4+40.0, 34.0, (self.view.frame.size.width-320)/4+40.0)];
    }
    else if ([NSStringFromClass(self.cellClasses[indexPath.row]) isEqualToString:NSStringFromClass([TC5PhraseTableViewCellOdd class])] ||
             [NSStringFromClass(self.cellClasses[indexPath.row]) isEqualToString:NSStringFromClass([TC5PhraseTableViewCellEven class])]) {

        NSInteger index = indexPath.row-2;
        TC5PhraseTableViewCell *c = (TC5PhraseTableViewCell *)cell;
        TC5SearchCategory *searchCategory = self.searchCategories[index];
        c.categoryLabel.text = [searchCategory categoryName];
        c.categoryCountLabel.text = [NSString stringWithFormat:@"%ld phrases", [searchCategory.conversations count]];
        c.categoryImageView.image = [searchCategory.category image];
    }

    }
    else {

    if (!cell) {
        cell = (UITableViewCell *)[UINib UIKitFromClass:[TC5ConversationCatalogTableViewCell class]];
    }

    TC5ConversationCatalogTableViewCell *c = (TC5ConversationCatalogTableViewCell *)cell;

    c.conversationTitleLabel.numberOfLines = 0;
    TC5Conversation *conversation = self.searchResults[indexPath.row];
    c.conversationTitleLabel.text = [conversation nativeTitleText];
    c.categoryImageView.image = [conversation image];
    [c.conversationTitleLabel sizeToFit];

    }

    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.menuTableView) {
        [self performSegueWithIdentifier:kSeguePushTC5ConversationCatalogViewController
                                  sender:nil];
    }
    else {

        TC5ConversationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:
            NSStringFromClass([TC5ConversationViewController class])
        ];
        vc.currentIndex = indexPath.row;
        vc.conversations = self.searchResults;
        [self.navigationController pushViewController:vc
                                             animated:YES];

    }
}


#pragma mark - UISearchDisplayDelegate
- (void)filterContentForSearchText:(NSString *)searchText
                             scope:(NSString *)scope
{
    NSArray *conversations = [self.searchCategories[0] conversations];
    NSString *nativeLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage];
    NSArray *predicates = @[
        [NSPredicate predicateWithFormat:@"SELF.%@ contains[c] %@",
            [nativeLanguage stringByReplacingOccurrencesOfString:@"-" withString:@""],
            searchText
        ],
    ];
    self.searchResults = [conversations filteredArrayUsingPredicate:[NSCompoundPredicate orPredicateWithSubpredicates:predicates]];
}

- (BOOL)searchDisplayController:(UISearchDisplayController*)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                       objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
}

-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
}


#pragma mark - TC5SearchTableViewCellDelgate
- (void)touchedUpInsideWithTC5LaunguageTableViewCell:(TC5SearchTableViewCell *)cell
                                          fromButton:(UIButton *)fromButton
{
    [self performSegueWithIdentifier:kSegueModalTC5ChooseLanguageViewController
                              sender:kNotificationChoosedNativeLanguage];
}

- (void)touchedUpInsideWithTC5LaunguageTableViewCell:(TC5SearchTableViewCell *)cell
                                            toButton:(UIButton *)toButton
{
    [self performSegueWithIdentifier:kSegueModalTC5ChooseLanguageViewController
                              sender:kNotificationChoosedTranslatedLanguage];
}


#pragma mark - notification
- (void)nativeLanguageDidChoosedWithNotification:(NSNotification *)notification
{
    [self.menuTableView reloadData];
}


#pragma mark - event listener
- (IBAction)touchedUpInsideWithBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    if (barButtonItem == self.settingBarButtonItem) {
        [self performSegueWithIdentifier:kSegueModalTC5SettingViewController
                                  sender:nil];
    }
    else if (barButtonItem == self.searchBarButtonItem) {
        [self.searchDisplayController.searchBar becomeFirstResponder];
    }
}


#pragma mark - private api


@end

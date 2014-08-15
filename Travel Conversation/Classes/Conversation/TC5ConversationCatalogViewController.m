#import "TC5ConversationCatalogViewController.h"
#import "IonIcons.h"
#import "UINib+UIKit.h"
#import "TC5Conversation.h"
#import "TC5ConversationViewController.h"
#import "TC5ConversationCatalogTableViewCell.h"


#pragma mark - TC5ConversationCatalogViewController
@implementation TC5ConversationCatalogViewController


#pragma mark - synthesize
@synthesize tableView;
@synthesize conversations;


#pragma mark - release
- (void)dealloc
{
    self.conversations = nil;
}


#pragma mark - life cycle
- (void)loadView
{
    [super loadView];

    // barbuttonItem
    [self.navigationItem.leftBarButtonItem setImage:[IonIcons imageWithIcon:icon_arrow_left_a size:32 color:[UIColor whiteColor]]];
    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(-4, -6, -4, 6)];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    TC5ConversationViewController *vc = (TC5ConversationViewController *)[segue destinationViewController];
    vc.currentIndex = [[self.tableView indexPathForSelectedRow] row];
    vc.conversations = self.conversations;

    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow]
                             animated:YES];
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.conversations.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TC5Conversation *conversation = self.conversations[indexPath.row];
    NSString *text = [conversation nativeTitleText];
    return [TC5ConversationCatalogTableViewCell estimatedHeight:[UIFont systemFontOfSize:17]
                                                           text:text
                                                           size:CGSizeMake(240, MAXFLOAT)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TC5ConversationCatalogTableViewCell *cell = (TC5ConversationCatalogTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TC5ConversationCatalogViewController class])];
    if (!cell) {
        Class cellClass = [TC5ConversationCatalogTableViewCell class];
        cell = (TC5ConversationCatalogTableViewCell *)[UINib UIKitFromClass:cellClass];

        cell.conversationTitleLabel.numberOfLines = 0;
        TC5Conversation *conversation = self.conversations[indexPath.row];
        cell.conversationTitleLabel.text = [conversation nativeTitleText];
        cell.categoryImageView.image = [conversation image];
        [cell.conversationTitleLabel sizeToFit];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kSeguePushTC5ConversationViewController
                              sender:self];
}


#pragma mark - event listener
- (IBAction)touchedUpInsideWithBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end

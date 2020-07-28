#import "TC5ChooseLanguageViewController.h"
// #import "IonIcons.h"
#import "UINib+UIKit.h"
#import "TC5ChooseLanguageTableViewCell.h"
#import "TC5CountryList.h"


#pragma mark - TC5ChooseLanguageViewController
@implementation TC5ChooseLanguageViewController


#pragma mark - synthesize
@synthesize languages;
@synthesize notificationName;
@synthesize selectedIndexPathRow;
@synthesize tableView;
@synthesize closeBarButtonItem;


#pragma mark - release
- (void)dealloc
{
    self.notificationName = nil;
    self.languages = nil;
}


#pragma mark - life cycle
- (void)loadView
{
    [super loadView];

    NSString *language = ([self.notificationName isEqualToString:kNotificationChoosedNativeLanguage]) ?
        [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage] :
        [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsTranslatedLanguage];

    self.selectedIndexPathRow = 0;

    // languages
    self.languages = [NSMutableArray array];
    [self.languages addObject:language];
    for (NSString *speechVoiceLanguage in kSpeechVoiceLanguages) {
        if ([speechVoiceLanguage isEqualToString:language]) { continue; }
        [self.languages addObject:speechVoiceLanguage];
    }

    // barbuttonItem
    // [self.closeBarButtonItem setImage:[IonIcons imageWithIcon:icon_ios7_close_empty size:40 color:[UIColor whiteColor]]];
    [self.closeBarButtonItem setImage:[[UIImage systemImageNamed:@"xmark" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:40]] imageWithTintColor:[UIColor whiteColor]]];
    [self.closeBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.closeBarButtonItem setImageInsets:UIEdgeInsetsMake(-4, -6, -4, 6)];
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.languages.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TC5ChooseLanguageTableViewCell TC5Height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TC5ChooseLanguageTableViewCell *cell = (TC5ChooseLanguageTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TC5ChooseLanguageViewController class])];
    if (!cell) {
        BOOL selected = (indexPath.row == self.selectedIndexPathRow);
        NSString *nibName = [NSString stringWithFormat:@"%@%@",
            NSStringFromClass([TC5ChooseLanguageTableViewCell class]),
            selected ? @"Selected" : @""
        ];
        cell = (TC5ChooseLanguageTableViewCell *)[UINib UIKitFromClassName:nibName];
        cell.languageFlagImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Language_%@.png", self.languages[indexPath.row]]];
        cell.languageTitleLabel.text = [[TC5CountryList sharedInstance] countryWithLanguage:self.languages[indexPath.row]];
        [cell.checkMarkImageView setHidden:!selected];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPathRow = indexPath.row;
    [self.tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    [self.tableView reloadData];

    self.view.userInteractionEnabled = NO;
    self.closeBarButtonItem.enabled = NO;

    [self performSelector:@selector(chooseLanguage)
               withObject:nil
               afterDelay:0.30f];
}


#pragma mark - event listener
- (IBAction)touchedUpInsideWithBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationController dismissViewControllerAnimated:YES
                                                  completion:^ () {}];
}


#pragma mark - private api
- (void)chooseLanguage
{
    [self performSelectorOnMainThread:@selector(saveLanguage)
                               withObject:nil
                            waitUntilDone:YES];
}

- (void)saveLanguage
{
    NSString *key = ([self.notificationName isEqualToString:kNotificationChoosedNativeLanguage]) ?
        kUserDefaultsNativeLanguage : kUserDefaultsTranslatedLanguage;
    NSString *language = self.languages[self.selectedIndexPathRow];
    [[NSUserDefaults standardUserDefaults] setObject:language
                                              forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[NSNotificationCenter defaultCenter] postNotificationName:self.notificationName
                                                        object:nil
                                                      userInfo:@{}];
    [self touchedUpInsideWithBarButtonItem:nil];
}


@end

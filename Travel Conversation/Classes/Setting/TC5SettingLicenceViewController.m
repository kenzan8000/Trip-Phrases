#import "TC5SettingLicenceViewController.h"
// #import "IonIcons.h"


#pragma mark - TC5SettingLicenceViewController
@implementation TC5SettingLicenceViewController


#pragma mark - synthesize
@synthesize textView;
@synthesize backBarButtonItem;


#pragma mark - release
- (void)dealloc
{
}


#pragma mark - life cycle
- (void)loadView
{
    [super loadView];

    self.title = @"Licence";
    // Licence
    [self initializeLicence];
    // barbuttonItem
    // [self.backBarButtonItem setImage:[IonIcons imageWithIcon:icon_arrow_left_a size:32 color:[UIColor whiteColor]]];
    [self.backBarButtonItem setImage:[[UIImage systemImageNamed:@"arrow.left" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:32]] imageWithTintColor:[UIColor whiteColor]]];
    [self.backBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.backBarButtonItem setImageInsets:UIEdgeInsetsMake(-4, -6, -4, 6)];
}


#pragma mark - event listener
- (IBAction)touchedUpInsideWithBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - private api
/**
 * licenceのテキストを設定
 */
- (void)initializeLicence
{
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:
        [[NSBundle mainBundle] pathForResource:kPlistAcknowledgements ofType:@"plist"]
    ];
    if ([plist isKindOfClass:[NSDictionary class]] == NO) { return; }
    if ([[plist allKeys] containsObject:@"PreferenceSpecifiers"] == NO) { return; }
    NSArray *licences = plist[@"PreferenceSpecifiers"];
    if ([licences isKindOfClass:[NSArray class]] == NO) { return; }

    NSMutableString *text = [NSMutableString stringWithCapacity:0];
    BOOL isFirstLine = YES;
    for  (NSDictionary *licence in licences) {
        if ([licence isKindOfClass:[NSDictionary class]] == NO) { continue; }
        NSArray *allKeys = [licence allKeys];
        if ([allKeys containsObject:@"Title"] == NO) { continue; }
        if ([allKeys containsObject:@"FooterText"] == NO) { continue; }

        if (isFirstLine == NO) {
            [text appendString:@"\n"];
            [text appendString:@"\n"];
            [text appendString:@"\n"];
            [text appendString:@"\n"];
        }

        [text appendString:licence[@"Title"]];
        [text appendString:@"\n"];
        [text appendString:@"\n"];
        [text appendString:licence[@"FooterText"]];

        isFirstLine = NO;
    }
    [self.textView setText:text];
}


@end

#import "TC5SettingSocialTableViewCell.h"
#import <Social/Social.h>
#import "IonIcons.h"
//#import "MTStatusBarOverlay.h"
#import "UIColor+Hexadecimal.h"
#import "QBFlatButton.h"


#pragma mark - TC5SettingSocialTableViewCell
@implementation TC5SettingSocialTableViewCell


#pragma mark - synthesize
@synthesize reviewButton;


#pragma mark - class method
+ (CGFloat)TC5Height
{
    return TC5SettingSocialTableViewCellHeight;
}


#pragma mark - initializer
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.reviewButton.depth = 2.0f;
    //self.reviewButton.margin = 2.0f;
}


#pragma mark - release
- (void)dealloc
{
}


#pragma mark - event listener
- (IBAction)touchedUpInsideWithButton:(UIButton *)button
{
    NSString *title = [self.reviewButton titleForState:UIControlStateNormal];
    if ([title isEqualToString:@"Tweet"]) {
        [self tweet];
    }
    else if ([title isEqualToString:@"Post"]) {
        [self publishToFacebook];
    }
    else if ([title isEqualToString:@"Review"]) {
        [self review];
    }
}


#pragma mark - api
- (void)setTitleWithTitleString:(NSString *)title
{
    [self.reviewButton setTitle:title
                       forState:UIControlStateNormal];

    // アイコン
    UIImage *image = nil;
    // ボタン色
    NSArray *colors = nil;
    if ([title isEqualToString:@"Tweet"]) {
        colors = @[
            [UIColor colorWithHexadecimal:0x00c6f2ff],
            [UIColor colorWithHexadecimal:0x00b0cfff],
            [UIColor colorWithHexadecimal:0x00b0cfff],
            [UIColor colorWithHexadecimal:0x0098b8ff],
        ];
        image = [IonIcons imageWithIcon:icon_social_twitter size:32 color:[UIColor colorWithHexadecimal:0xffffffff]];
    }
    else if ([title isEqualToString:@"Post"]) {
        colors = @[
            [UIColor colorWithHexadecimal:0x3b5998ff],
            [UIColor colorWithHexadecimal:0x284181ff],
            [UIColor colorWithHexadecimal:0x284181ff],
            [UIColor colorWithHexadecimal:0x102868ff],
        ];
        image = [IonIcons imageWithIcon:icon_social_facebook size:32 color:[UIColor colorWithHexadecimal:0xffffffff]];
    }
    else if ([title isEqualToString:@"Review"]) {
        colors = @[
            [UIColor colorWithHexadecimal:0xb0b0b0ff],
            [UIColor colorWithHexadecimal:0x909090ff],
            [UIColor colorWithHexadecimal:0x909090ff],
            [UIColor colorWithHexadecimal:0x707070ff],
        ];
        image = [IonIcons imageWithIcon:icon_compose size:32 color:[UIColor colorWithHexadecimal:0xffffffff]];
    }
    [self.reviewButton setSurfaceColor:colors[0]
                           forState:UIControlStateNormal];
    [self.reviewButton setSurfaceColor:colors[1]
                           forState:UIControlStateHighlighted];
    [self.reviewButton setSideColor:colors[2]
                           forState:UIControlStateNormal];
    [self.reviewButton setSideColor:colors[3]
                           forState:UIControlStateHighlighted];

    [self setIconWithImage:image];
}

- (void)setIconWithImage:(UIImage *)image
{
    [self.reviewButton setImage:image
                       forState:UIControlStateNormal];
}


#pragma mark - private api
/**
 * tweet
 */
- (void)tweet
{
    [self postToSocialWithServiceType:SLServiceTypeTwitter];
}

/**
 * publish to facebook
 */
- (void)publishToFacebook
{
    [self postToSocialWithServiceType:SLServiceTypeFacebook];
}

/**
 * Socialへ投稿
 * @param serviceType Socialの種類
 */
- (void)postToSocialWithServiceType:(NSString *)serviceType
{
    // 投稿
     if ([SLComposeViewController isAvailableForServiceType:serviceType]) {
        SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        [vc setInitialText:[NSString stringWithFormat:@"%@\n%@",
            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"],
            kURLAppStore
        ]];
        [vc setCompletionHandler:^ (SLComposeViewControllerResult result) {
            // 成功
            if (result == SLComposeViewControllerResultDone) {
            }
            else if (result == SLComposeViewControllerResultCancelled) {
            }
        }];

        if ([self.delegate respondsToSelector:@selector(presentViewController:cell:)]) {
             [self.delegate presentViewController:vc cell:self];
        }
    }
}

- (void)review
{
    NSURL *URL = [NSURL URLWithString:kURLAppStore];
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        [[UIApplication sharedApplication] openURL:URL];
    }
}


@end

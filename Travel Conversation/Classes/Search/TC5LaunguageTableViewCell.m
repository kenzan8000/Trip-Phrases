#import "TC5LaunguageTableViewCell.h"
#import "TC5LocalizationList.h"


#pragma mark - TC5LaunguageTableViewCell
@implementation TC5LaunguageTableViewCell


#pragma mark - synthesize
@synthesize backgroundImageView;
@synthesize fromLabel;
@synthesize toLabel;
@synthesize fromButton;
@synthesize toButton;
@synthesize delegate;


#pragma mark - initializer
- (void)awakeFromNib
{
    [super awakeFromNib];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(nativeLanguageDidChoosedWithNotification:)
                                                 name:kNotificationChoosedNativeLanguage
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(translatedLanguageDidChoosedWithNotification:)
                                                 name:kNotificationChoosedTranslatedLanguage
                                               object:nil];
    [self nativeLanguageDidChoosedWithNotification:nil];
}


#pragma mark - release
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - event listener
- (IBAction)touchedUpInsideWithButton:(UIButton *)button
{
    // call delegate
    SEL selector = NULL;
    if (button == self.fromButton) {
        selector = @selector(touchedUpInsideWithTC5LaunguageTableViewCell:fromButton:);
    }
    else if (button == self.toButton) {
        selector = @selector(touchedUpInsideWithTC5LaunguageTableViewCell:toButton:);
    }
    else { return; }
    if (self.delegate == nil ||
        [self.delegate respondsToSelector:selector] == NO) {
        return;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.delegate performSelector:selector
                        withObject:self
                        withObject:button];
#pragma clang diagnostic pop
}


#pragma mark - notification
- (void)nativeLanguageDidChoosedWithNotification:(NSNotification *)notification
{
    NSString *nativeLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage];
    NSString *translatedLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsTranslatedLanguage];
    [self loadNativeLanguage:nativeLanguage
          translatedLanguage:translatedLanguage];
}

- (void)translatedLanguageDidChoosedWithNotification:(NSNotification *)notification
{
    NSString *nativeLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage];
    NSString *translatedLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsTranslatedLanguage];
    [self loadNativeLanguage:nativeLanguage
          translatedLanguage:translatedLanguage];
}


#pragma mark - public api
+ (CGFloat)TC5Height
{
    return 128;
}


#pragma mark - private api
- (void)loadNativeLanguage:(NSString *)nativeLanguage
        translatedLanguage:(NSString *)translatedLanguage
{
    [self.fromButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Language_%@.png", nativeLanguage]]
                     forState:UIControlStateNormal];
    [self.toButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Language_%@.png", translatedLanguage]]
                   forState:UIControlStateNormal];

    self.fromLabel.text = [[TC5LocalizationList sharedInstance] localizationWithEnglishKey:@"Native Language"];
    self.toLabel.text = [[TC5LocalizationList sharedInstance] localizationWithEnglishKey:@"Foreign language"];
    self.fromLabel.layer.cornerRadius = 4;
    self.fromLabel.clipsToBounds = YES;
    self.toLabel.layer.cornerRadius = 4;
    self.toLabel.clipsToBounds = YES;

    {
    UIImage *srcImage = [UIImage imageNamed:[NSString stringWithFormat:@"Scenery_%@.jpg", translatedLanguage]];
    UIImage *dstImage = nil;
    CGFloat ratio =  self.frame.size.height / self.frame.size.width;
    CGFloat height = srcImage.size.width * ratio;
    CGRect clipRect = CGRectMake(0, (srcImage.size.height - height) / 2.0f, srcImage.size.width, height);
    CGImageRef cliped = CGImageCreateWithImageInRect(srcImage.CGImage, clipRect);
    dstImage = [UIImage imageWithCGImage:cliped
                                   scale:[[UIScreen mainScreen] scale]
                             orientation:UIImageOrientationUp];
    CGImageRelease(cliped);
    self.backgroundImageView.image = dstImage;
    }
}


@end

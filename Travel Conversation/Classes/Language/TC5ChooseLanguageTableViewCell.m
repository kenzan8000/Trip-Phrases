#import "TC5ChooseLanguageTableViewCell.h"
// #import "IonIcons.h"


#pragma mark - TC5ChooseLanguageTableViewCell
@implementation TC5ChooseLanguageTableViewCell


#pragma mark - synthesize
@synthesize checkBoxBackgroundImageView;
@synthesize checkBoxForegroundImageView;
@synthesize checkMarkImageView;
@synthesize languageFlagImageView;
@synthesize languageTitleLabel;


#pragma mark - initializer
- (void)awakeFromNib
{
    [super awakeFromNib];
    /*
    self.checkBoxBackgroundImageView.image = [IonIcons imageWithIcon:icon_stop
                                                                size:self.checkBoxBackgroundImageView.frame.size.width*2
                                                               color:[UIColor grayColor]];
    self.checkBoxForegroundImageView.image = [IonIcons imageWithIcon:icon_stop
                                                                size:self.checkBoxForegroundImageView.frame.size.width*2
                                                               color:[UIColor whiteColor]];
    self.checkMarkImageView.image = [IonIcons imageWithIcon:icon_ios7_checkmark_empty
                                                       size:self.checkMarkImageView.frame.size.width*2
                                                      color:[UIColor blackColor]];
     */
    self.checkBoxBackgroundImageView.image = [[UIImage systemImageNamed:@"stop.fill" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:self.checkBoxBackgroundImageView.frame.size.width*2]] imageWithTintColor:[UIColor grayColor]];
    self.checkBoxBackgroundImageView.tintColor = [UIColor grayColor];
    self.checkBoxForegroundImageView.image = [[UIImage systemImageNamed:@"stop.fill" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:self.checkBoxForegroundImageView.frame.size.width*2]] imageWithTintColor:[UIColor whiteColor]];
    self.checkBoxForegroundImageView.tintColor = [UIColor whiteColor];
    self.checkMarkImageView.image = [[UIImage systemImageNamed:@"checkmark" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:self.checkMarkImageView.frame.size.width*2]] imageWithTintColor:[UIColor blackColor]];
    self.checkMarkImageView.tintColor = [UIColor blackColor];
}


#pragma mark - release
- (void)dealloc
{
}


#pragma mark - event listener


#pragma mark - public api
+ (CGFloat)TC5Height
{
    return 56;
}


@end

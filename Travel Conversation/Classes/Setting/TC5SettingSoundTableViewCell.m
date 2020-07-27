#import "TC5SettingSoundTableViewCell.h"
#import "TC5LocalizationList.h"
#import <MediaPlayer/MediaPlayer.h>
// #import "IonIcons.h"
#import "UIColor+Hexadecimal.h"


#pragma mark - TC5SettingSoundTableViewCell
@implementation TC5SettingSoundTableViewCell


#pragma mark - synthesize


#pragma mark - initializer
- (void)awakeFromNib
{
    [super awakeFromNib];

    // volume
    // [self.volumeImageView setImage:[IonIcons imageWithIcon:icon_volume_medium size:40 color:[UIColor colorWithHexadecimal:0x34495eff]]];
    [self.volumeImageView setImage:[[UIImage systemImageNamed:@"speaker.fill" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:40]] imageWithTintColor:[UIColor colorWithHexadecimal:0x34495eff]]];
    CGRect rect = self.volumeBackgroundView.frame;
    rect.origin.x = rect.origin.y = 0;
    self.volumeView = [[MPVolumeView alloc] initWithFrame:rect];
    [self.volumeView setShowsVolumeSlider:YES];
    [self.volumeView setShowsRouteButton:YES];
    [self.volumeView sizeToFit];
    [self.volumeBackgroundView addSubview:self.volumeView];

    // play
    [self.playSpeedSlider setMinimumValue:kPlaySpeedManimum];
    [self.playSpeedSlider setMaximumValue:kPlaySpeedMaximum];
    CGFloat speed = [[NSUserDefaults standardUserDefaults] floatForKey:kUserDefaultsPlaySpeed];
    [self.playSpeedSlider setValue:speed
                          animated:NO];
    // [self.playSpeedImageView setImage:[IonIcons imageWithIcon:icon_speedometer size:40 color:[UIColor colorWithHexadecimal:0x34495eff]]];
    [self.playSpeedImageView setImage:[[UIImage systemImageNamed:@"speedometer" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:40]] imageWithTintColor:[UIColor colorWithHexadecimal:0x34495eff]]];

    // label
//    self.volumeLabel.text = [[TC5LocalizationList sharedInstance] localizationWithEnglishKey:@"Volume"];
//    self.playSpeedLabel.text = [[TC5LocalizationList sharedInstance] localizationWithEnglishKey:@"Play Speed"];
}

#pragma mark - release
- (void)dealloc
{
    [self.volumeView removeFromSuperview];
    self.volumeView = nil;
}


#pragma mark - UISliderDelegate
- (IBAction)sliderValueWasChanged:(UISlider *)slider
{
    [[NSUserDefaults standardUserDefaults] setFloat:slider.value
                                             forKey:kUserDefaultsPlaySpeed];
}


#pragma mark - event listener


#pragma mark - public api
+ (CGFloat)TC5Height
{
    return 160;
}


@end

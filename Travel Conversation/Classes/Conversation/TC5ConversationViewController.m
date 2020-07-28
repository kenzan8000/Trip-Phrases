#import "TC5ConversationViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
// #import "IonIcons.h"
#import "QBFlatButton.h"
#import "SwipeView.h"
#import "UINib+UIKit.h"
#import "UIColor+Hexadecimal.h"
#import "TC5Conversation.h"
#import "TC5CountryList.h"
#import "TC5LanguageList.h"
#import "TC5SettingSoundTableViewCell.h"


#pragma mark - TC5ConversationViewController
@implementation TC5ConversationViewController


#pragma mark - synthesize
@synthesize swipeView;
@synthesize playButton;
@synthesize pickerBackgroundView;
@synthesize pickerContainView;
@synthesize pickerChooseButton;
@synthesize pickerView;
@synthesize soundSettingView;
@synthesize soundSettingCell;
@synthesize swipeHintView;
@synthesize swipeLeftHintView;
@synthesize swipeRightHintView;
@synthesize swipeLeftHintImageView;
@synthesize swipeRightHintImageView;
@synthesize backBarButtonItem;
@synthesize settingBarButtonItem;
@synthesize speechSynthesizer;
@synthesize currentIndex;
@synthesize conversations;
@synthesize pickerList;


#pragma mark - release
- (void)dealloc
{
    [self stop];
    self.speechSynthesizer = nil;
    self.conversations = nil;
    self.pickerList = nil;
}


#pragma mark - life cycle
- (void)loadView
{
    [super loadView];

    [self.playButton setFaceColor:[UIColor colorWithHexadecimal:0xf39c12ff] forState:UIControlStateNormal];
    [self.playButton setFaceColor:[UIColor colorWithHexadecimal:0xe67e22ff] forState:UIControlStateHighlighted];
    [self.playButton setSideColor:[UIColor colorWithHexadecimal:0xe67e22ff] forState:UIControlStateNormal];
    [self.playButton setSideColor:[UIColor colorWithHexadecimal:0xd35400ff] forState:UIControlStateHighlighted];
    // [self.playButton setImage:[IonIcons imageWithIcon:icon_play size:32 color:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.playButton setImage:[[UIImage systemImageNamed:@"play.fill" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:32]] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.playButton setTintColor:[UIColor whiteColor]];

    // hint
    self.swipeLeftHintView.layer.cornerRadius = 30;
    self.swipeLeftHintView.clipsToBounds = YES;
    self.swipeRightHintView.layer.cornerRadius = 30;
    self.swipeRightHintView.clipsToBounds = YES;
    // self.swipeLeftHintImageView.image = [IonIcons imageWithIcon:icon_ios7_arrow_back size:60 color:[UIColor whiteColor]];
    self.swipeLeftHintImageView.image = [[UIImage systemImageNamed:@"chevron.left" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:60]] imageWithTintColor:[UIColor whiteColor]];
    self.swipeLeftHintImageView.tintColor = [UIColor whiteColor];
    // self.swipeRightHintImageView.image = [IonIcons imageWithIcon:icon_ios7_arrow_forward size:60 color:[UIColor whiteColor]];
    self.swipeRightHintImageView.image = [[UIImage systemImageNamed:@"chevron.right" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:60]] imageWithTintColor:[UIColor whiteColor]];
    self.swipeRightHintImageView.tintColor = [UIColor whiteColor];
    if (self.currentIndex <= 0) {
        self.swipeLeftHintView.hidden = YES;
    }
    if (self.currentIndex >= [self.conversations count] - 1) {
        self.swipeRightHintView.hidden = YES;
    }

    self.speechSynthesizer = [AVSpeechSynthesizer new];
//    self.speechSynthesizer.delegate = self;

    self.swipeView.pagingEnabled = YES;
    [self.swipeView scrollToPage:self.currentIndex
                        duration:0];

    [self.pickerView selectRow:0
                   inComponent:0
                      animated:NO];
    // barbuttonItem
    // [self.backBarButtonItem setImage:[IonIcons imageWithIcon:icon_arrow_left_a size:32 color:[UIColor whiteColor]]];
    [self.backBarButtonItem setImage:[[UIImage systemImageNamed:@"arrow.left" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:32]] imageWithTintColor:[UIColor whiteColor]]];
    [self.backBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.backBarButtonItem setImageInsets:UIEdgeInsetsMake(-4, -6, -4, 6)];
    // [self.settingBarButtonItem setImage:[IonIcons imageWithIcon:icon_ios7_arrow_down size:32 color:[UIColor whiteColor]]];
    [self.settingBarButtonItem setImage:[[UIImage systemImageNamed:@"chevron.down" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:32]] imageWithTintColor:[UIColor whiteColor]]];
    [self.settingBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.settingBarButtonItem setImageInsets:UIEdgeInsetsMake(-4, -6, -4, 6)];

    [self setNavigationBarTitle];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    __weak __typeof(self) weakSelf = self;

    [weakSelf.swipeHintView setHidden:NO];
    [weakSelf.swipeHintView setAlpha:1];

    [UIView animateWithDuration:1.0f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^ () {
        [weakSelf.swipeHintView setAlpha:0];
    }
                     completion:^ (BOOL finished) {
        [weakSelf.swipeHintView setHidden:YES];
    }];

}


#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    NSInteger row = [self.pickerList count];
    return row;
}

- (NSString*)pickerView:(UIPickerView*)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component
{
    NSString *content = [self.pickerList objectAtIndex:row];
    return content;
}


#pragma mark - SwipeViewDelegate
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [self.conversations count];
}

- (UIView *)swipeView:(SwipeView *)swipeView
   viewForItemAtIndex:(NSInteger)index
          reusingView:(UIView *)view
{
    if (view == nil) {
        view = (TC5ConversationView *)[UINib UIKitFromClass:[TC5ConversationView class]];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }

    TC5ConversationView *v = (TC5ConversationView *)view;

    TC5Conversation *conversation = [self.conversations objectAtIndex:index];

    // default settings
    NSInteger defaultIndex = 0;
    NSArray *defaultsettings = @[@"%country", @"%language"];
    for (NSInteger i = 0; i < defaultsettings.count; i++) {
        NSString *defaultSetting = defaultsettings[i];
        NSRange range = [[conversation translatedText] rangeOfString:defaultSetting];
        if (range.length > 0) {
            if (i == 0) { defaultIndex = [[TC5CountryList sharedInstance] nativeIndex]; }
            else if (i == 1) { defaultIndex = [[TC5LanguageList sharedInstance] nativeIndex]; }
        }
    }

    [v setTextWithConversation:conversation
                     listIndex:defaultIndex];

    v.delegate = self;

    return view;
}

- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    self.currentIndex = self.swipeView.currentPage;
    [self setNavigationBarTitle];
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}


#pragma mark - TC5ConversationViewDelegate
- (void)playButtonTouchedUpInsideWithConversationView:(UIView *)conversationView
{
    [self touchedUpInsideWithButton:self.playButton];
}

- (void)pickerTouchedUpInsideWithConversationView:(UIView *)conversationView
                                     conversation:(TC5Conversation *)conversation
{
    self.pickerList = [conversation replacementList];
    [self.pickerView reloadAllComponents];
    [self showPickerView];
}


#pragma mark - event listener
- (IBAction)touchedUpInsideWithButton:(UIButton *)button
{
    if (button == self.playButton) {
        [self stop];
        [self play];
    }
    else if (button == self.pickerChooseButton) {
        TC5ConversationView *v = (TC5ConversationView *)[self.swipeView currentItemView];
        TC5Conversation *conversation = [self.conversations objectAtIndex:self.swipeView.currentPage];
        [v setTextWithConversation:conversation
                         listIndex:[self.pickerView selectedRowInComponent:0]];

        [self hidePickerView];
    }
}

- (IBAction)touchedUpInsideWithBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    if (barButtonItem == self.backBarButtonItem) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (barButtonItem == self.settingBarButtonItem) {
        if (self.soundSettingView.hidden) { [self showSoundSettingView]; }
        else { [self hideSoundSettingView]; }
    }
}


#pragma mark - private api
- (void)play
{
    NSString *translatedLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsTranslatedLanguage];
    NSString *speech = [(TC5ConversationView *)[self.swipeView currentItemView] translatedText];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:speech];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:translatedLanguage];
    CGFloat speed = [[NSUserDefaults standardUserDefaults] floatForKey:kUserDefaultsPlaySpeed];
    utterance.rate = speed;
    utterance.pitchMultiplier = AVSpeechUtteranceMaximumSpeechRate;
    [self.speechSynthesizer speakUtterance:utterance];
}

- (void)stop
{
    [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (void)setNavigationBarTitle
{
    NSInteger index = self.currentIndex+1;
    if (index <= 0) { index = 1; }
    if (index > self.conversations.count) { index = self.conversations.count; }
    self.title = [NSString stringWithFormat:@"%@ / %@", @(index), @(self.conversations.count)];
}

- (void)showPickerView
{
    [self.pickerBackgroundView setHidden:NO];
    self.pickerBackgroundView.frame = CGRectMake(0, self.pickerView.frame.size.height, self.pickerBackgroundView.frame.size.width, self.pickerBackgroundView.frame.size.height);


    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^ () {
        weakSelf.pickerBackgroundView.frame = CGRectMake(0, 0, weakSelf.pickerBackgroundView.frame.size.width, weakSelf.pickerBackgroundView.frame.size.height);
    }
                     completion:^ (BOOL finished) {
    }];
}

- (void)hidePickerView
{
    self.pickerBackgroundView.frame = CGRectMake(0, 0, self.pickerBackgroundView.frame.size.width, self.pickerBackgroundView.frame.size.height);

    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.20
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^ () {
        weakSelf.pickerBackgroundView.frame = CGRectMake(0, weakSelf.pickerView.frame.size.height, weakSelf.pickerBackgroundView.frame.size.width, weakSelf.pickerBackgroundView.frame.size.height);
    }
                     completion:^ (BOOL finished) {
        [weakSelf.pickerBackgroundView setHidden:YES];
    }];
}

- (void)showSoundSettingView
{
    // [self.settingBarButtonItem setImage:[IonIcons imageWithIcon:icon_ios7_arrow_up size:32 color:[UIColor whiteColor]]];
    [self.settingBarButtonItem setImage:[[UIImage systemImageNamed:@"chevron.up" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:32]] imageWithTintColor:[UIColor whiteColor]]];
    [self.settingBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.settingBarButtonItem setImageInsets:UIEdgeInsetsMake(-4, -6, -4, 6)];

    CGFloat offset = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;

    [self.soundSettingView setHidden:NO];
    self.soundSettingView.frame = CGRectMake(0, -self.soundSettingCell.frame.size.height-offset, self.soundSettingView.frame.size.width, self.soundSettingView.frame.size.height);


    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.32f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^ () {
        weakSelf.soundSettingView.frame = CGRectMake(0, offset, weakSelf.soundSettingView.frame.size.width, weakSelf.soundSettingView.frame.size.height);
    }
                     completion:^ (BOOL finished) {
    }];

}

- (void)hideSoundSettingView
{
    // [self.settingBarButtonItem setImage:[IonIcons imageWithIcon:icon_ios7_arrow_down size:32 color:[UIColor whiteColor]]];
    [self.settingBarButtonItem setImage:[[UIImage systemImageNamed:@"chevron.down" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:32]] imageWithTintColor:[UIColor whiteColor]]];
    [self.settingBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.settingBarButtonItem setImageInsets:UIEdgeInsetsMake(-4, -6, -4, 6)];

    CGFloat offset = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;

    self.soundSettingView.frame = CGRectMake(0, offset, self.soundSettingView.frame.size.width, self.soundSettingView.frame.size.height);

    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^ () {
        weakSelf.soundSettingView.frame = CGRectMake(0, -weakSelf.soundSettingCell.frame.size.height-offset-40, weakSelf.soundSettingView.frame.size.width, weakSelf.soundSettingView.frame.size.height);
    }
                     completion:^ (BOOL finished) {
        [weakSelf.soundSettingView setHidden:YES];
    }];
}

-(void)touchesBegan:(NSSet *)touches
          withEvent:(UIEvent *)event
{
    if (self.pickerBackgroundView.hidden == NO) {
        BOOL contain = CGRectContainsPoint(self.pickerContainView.frame, [[[event allTouches] anyObject] locationInView:self.view]);
        if (contain == NO) {
            [self hidePickerView];
        }
    }
    else if (self.soundSettingView.hidden == NO) {
        BOOL contain = CGRectContainsPoint(self.soundSettingCell.frame, [[[event allTouches] anyObject] locationInView:self.view]);
        if (contain == NO) {
            [self hideSoundSettingView];
        }
    }
}

@end

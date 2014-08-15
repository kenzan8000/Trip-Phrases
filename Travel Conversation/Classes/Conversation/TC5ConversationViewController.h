#import "TC5ConversationView.h"


#pragma mark - class
@class AVSpeechSynthesizer;
@class SwipeView;
@class QBFlatButton;
@class TC5SettingSoundTableViewCell;


#pragma mark - TC5ConversationViewController
@interface TC5ConversationViewController : UIViewController <TC5ConversationViewDelegate> {
}


#pragma mark - property
@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (weak, nonatomic) IBOutlet QBFlatButton *playButton;

@property (weak, nonatomic) IBOutlet UIView *pickerBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *pickerContainView;
@property (weak, nonatomic) IBOutlet UIButton *pickerChooseButton;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIView *soundSettingView;
@property (weak, nonatomic) IBOutlet TC5SettingSoundTableViewCell *soundSettingCell;

@property (weak, nonatomic) IBOutlet UIView *swipeHintView;
@property (weak, nonatomic) IBOutlet UIView *swipeLeftHintView;
@property (weak, nonatomic) IBOutlet UIView *swipeRightHintView;
@property (weak, nonatomic) IBOutlet UIImageView *swipeLeftHintImageView;
@property (weak, nonatomic) IBOutlet UIImageView *swipeRightHintImageView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingBarButtonItem;

@property (strong, nonatomic) AVSpeechSynthesizer *speechSynthesizer;

@property (assign, nonatomic) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *conversations;
@property (nonatomic, strong) NSArray *pickerList;


#pragma mark - event listener
- (IBAction)touchedUpInsideWithBarButtonItem:(UIBarButtonItem *)barButtonItem;

- (IBAction)touchedUpInsideWithButton:(UIButton *)button;


@end

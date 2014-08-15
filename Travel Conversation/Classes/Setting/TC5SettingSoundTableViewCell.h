#pragma mark - class
@class MPVolumeView;


#pragma mark - TC5SettingSoundTableViewCell
@interface TC5SettingSoundTableViewCell : UITableViewCell {
}


#pragma mark - property
@property (nonatomic, weak) IBOutlet UILabel *volumeLabel;
@property (nonatomic, weak) IBOutlet UILabel *playSpeedLabel;
@property (nonatomic, weak) IBOutlet UIImageView *volumeImageView;
@property (nonatomic, weak) IBOutlet UIImageView *playSpeedImageView;
@property (nonatomic, strong) MPVolumeView *volumeView;
@property (nonatomic, weak) IBOutlet UIView *volumeBackgroundView;
@property (nonatomic, weak) IBOutlet UISlider *playSpeedSlider;


#pragma mark - api
+ (CGFloat)TC5Height;


@end

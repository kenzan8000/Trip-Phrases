#pragma mark - TC5ChooseLanguageTableViewCell
@interface TC5ChooseLanguageTableViewCell : UITableViewCell {
}


#pragma mark - property
@property (nonatomic, weak) IBOutlet UIImageView *checkBoxBackgroundImageView;
@property (nonatomic, weak) IBOutlet UIImageView *checkBoxForegroundImageView;
@property (nonatomic, weak) IBOutlet UIImageView *checkMarkImageView;
@property (nonatomic, weak) IBOutlet UIImageView *languageFlagImageView;
@property (nonatomic, weak) IBOutlet UILabel *languageTitleLabel;


#pragma mark - api
+ (CGFloat)TC5Height;


@end

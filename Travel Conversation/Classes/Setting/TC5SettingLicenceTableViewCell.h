#pragma mark - constant
#define TC5SettingLicenceTableViewCellHeight 54


#pragma mark - TC5SettingLicenceTableViewCell
@interface TC5SettingLicenceTableViewCell : UITableViewCell {
}


#pragma mark - property
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;


#pragma mark - api
+ (CGFloat)TC5Height;


@end

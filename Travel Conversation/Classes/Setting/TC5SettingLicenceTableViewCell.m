#import "TC5SettingLicenceTableViewCell.h"


#pragma mark - TC5SettingLicenceTableViewCell
@implementation TC5SettingLicenceTableViewCell


#pragma mark - synthesize
@synthesize titleLabel;


#pragma mark - class method
+ (CGFloat)TC5Height
{
    return TC5SettingLicenceTableViewCellHeight;
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
    [self setTitleWithTitleString:@"Licence"];
}


#pragma mark - release
- (void)dealloc
{
}


#pragma mark - api
- (void)setTitleWithTitleString:(NSString *)title
{
    [self.titleLabel setText:title];
}


@end


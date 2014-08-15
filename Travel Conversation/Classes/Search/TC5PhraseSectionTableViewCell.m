#import "TC5PhraseSectionTableViewCell.h"
#import "TC5LocalizationList.h"


#pragma mark - TC5PhraseSectionTableViewCell
@implementation TC5PhraseSectionTableViewCell


#pragma mark - synthesize
@synthesize sectionLabel;


#pragma mark - event listener
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.sectionLabel.text = [[TC5LocalizationList sharedInstance] localizationWithEnglishKey:@"Category"];
}

#pragma mark - public api
+ (CGFloat)TC5Height
{
    return 20;
}


@end

#import "TC5ConversationCatalogTableViewCell.h"


#pragma mark - TC5ConversationCatalogTableViewCell
@implementation TC5ConversationCatalogTableViewCell


#pragma mark - synthesize
@synthesize conversationTitleLabel;
@synthesize categoryImageView;


#pragma mark - release
- (void)dealloc
{
}


#pragma mark - event listener


#pragma mark - public api
+ (CGFloat)estimatedHeight:(UIFont *)font
                      text:(NSString *)text
                      size:(CGSize)size
{
    NSDictionary *attributes = @{NSFontAttributeName: font};
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text
                                                                 attributes:attributes];
    CGRect rect = [string boundingRectWithSize:size
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                       context:nil];

    CGFloat margin = 15 * 2;
    return rect.size.height + margin;
}

+ (CGFloat)TC5Height
{
    return 56;
}


#pragma mark - private api
- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect frame = [self.conversationTitleLabel frame];
    frame.size = CGSizeMake(240, 0);
    [self.conversationTitleLabel setFrame:frame];
    [self.conversationTitleLabel sizeToFit];
}


@end

#pragma mark - TC5ConversationCatalogTableViewCell
@interface TC5ConversationCatalogTableViewCell : UITableViewCell {
}


#pragma mark - property
@property (nonatomic, weak) IBOutlet UILabel *conversationTitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *categoryImageView;


#pragma mark - api
+ (CGFloat)estimatedHeight:(UIFont *)font
                      text:(NSString *)text
                      size:(CGSize)size;

+ (CGFloat)TC5Height;


@end

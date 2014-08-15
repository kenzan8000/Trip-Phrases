#pragma mark - TC5ConversationList
@interface TC5ConversationList : NSObject {
}


#pragma mark - property


#pragma mark - class method
+ (TC5ConversationList *)sharedInstance;


#pragma mark - api
- (NSArray *)conversationsWithCategory:(NSString *)category;


@end

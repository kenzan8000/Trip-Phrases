#pragma mark - TC5GoodList
@interface TC5GoodList : NSObject {
}


#pragma mark - property


#pragma mark - class method
+ (TC5GoodList *)sharedInstance;


#pragma mark - api
- (NSArray *)goodListWithLanguage:(NSString *)language;


@end

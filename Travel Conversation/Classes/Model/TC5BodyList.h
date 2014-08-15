#pragma mark - TC5BodyList
@interface TC5BodyList : NSObject {
}


#pragma mark - property


#pragma mark - class method
+ (TC5BodyList *)sharedInstance;


#pragma mark - api
- (NSArray *)bodyListWithLanguage:(NSString *)language;


@end

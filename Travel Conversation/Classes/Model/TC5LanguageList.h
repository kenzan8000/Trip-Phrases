#pragma mark - TC5LanguageList
@interface TC5LanguageList : NSObject {
}


#pragma mark - property


#pragma mark - class method
+ (TC5LanguageList *)sharedInstance;


#pragma mark - api
- (NSString *)languageWithLanguage:(NSString *)language;

- (NSArray *)languageListWithLanguage:(NSString *)language;

- (NSString *)nativeLanguage;

- (NSInteger)nativeIndex;


@end

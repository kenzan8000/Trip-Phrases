#pragma mark - TC5LocalizationList
@interface TC5LocalizationList : NSObject {
}


#pragma mark - property


#pragma mark - class method
+ (TC5LocalizationList *)sharedInstance;


#pragma mark - api
- (NSArray *)localizationListWithLanguage:(NSString *)language;

- (NSString *)localizationWithEnglishKey:(NSString *)englishKey;


@end

#pragma mark - TC5CountryList
@interface TC5CountryList : NSObject {
}


#pragma mark - property


#pragma mark - class method
+ (TC5CountryList *)sharedInstance;


#pragma mark - api
- (NSString *)countryWithLanguage:(NSString *)language;

- (NSArray *)countryListWithLanguage:(NSString *)language;

- (NSString *)nativeCountry;

- (NSInteger)nativeIndex;


@end

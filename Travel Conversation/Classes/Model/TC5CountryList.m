#import "TC5CSV.h"
#import "TC5CountryList.h"


#pragma mark - TC5CountryList
@interface TC5CountryList ()


@property (nonatomic, strong) NSArray *countries;


@end


#pragma mark - TC5CountryList
@implementation TC5CountryList


#pragma mark - synthesize


#pragma mark - class method
+ (TC5CountryList *)sharedInstance
{
    static dispatch_once_t onceToken;
    static TC5CountryList *_TC5CountryList = nil;
    dispatch_once(&onceToken, ^ () {
        _TC5CountryList = [TC5CountryList new];
    });
    return _TC5CountryList;
}


#pragma mark - initializer
- (id)init
{
    self = [super init];
    if (self == nil) { return self; }
    [self createCountries];

    return self;
}


#pragma mark - dealloc
- (void)dealloc
{
    self.countries = nil;
}


#pragma mark - api
- (NSString *)countryWithLanguage:(NSString *)language
{
    NSInteger index = -1;
    NSArray *languages = self.countries;
    for (NSInteger i = 0; i < languages.count; i++) {
        if ([[languages[i] objectForKey:@"language"] isEqualToString:language] == NO) {
            continue;
        }

        index = i;
        break;
    }
    if (index < 0) { return nil; }

    NSString *nativeLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage];
    return [[self.countries objectAtIndex:index] objectForKey:nativeLanguage];
}

- (NSArray *)countryListWithLanguage:(NSString *)language
{
    NSMutableArray *list = [NSMutableArray new];
    for (NSInteger i = 0; i < self.countries.count; i++) {
        [list addObject:[self.countries[i] objectForKey:language]];
    }
    return list;
}

- (NSString *)nativeCountry
{
    NSString *nativeLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage];
    NSInteger index = -1;
    NSArray *languages = self.countries;
    for (NSInteger i = 0; i < languages.count; i++) {
        if ([[languages[i] objectForKey:@"language"] isEqualToString:nativeLanguage] == NO) {
            continue;
        }

        index = i;
        break;
    }
    if (index < 0) { return nil; }

    return [[self.countries objectAtIndex:index] objectForKey:nativeLanguage];
}

- (NSInteger)nativeIndex
{
    NSString *nativeLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage];
    NSInteger index = -1;
    NSArray *languages = self.countries;
    for (NSInteger i = 0; i < languages.count; i++) {
        if ([[languages[i] objectForKey:@"language"] isEqualToString:nativeLanguage] == NO) {
            continue;
        }

        index = i;
        break;
    }
    if (index < 0) { return 0; }
    return index;
}


#pragma mark - private api
- (void)createCountries
{
    TC5CSV *countryList = [TC5CSV new];
    [countryList loadCSVWithName:@"Country"];
    self.countries = countryList.datas;
}


@end

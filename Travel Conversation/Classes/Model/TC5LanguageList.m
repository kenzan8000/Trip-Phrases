#import "TC5CSV.h"
#import "TC5LanguageList.h"


#pragma mark - TC5LanguageList
@interface TC5LanguageList ()


@property (nonatomic, strong) NSArray *countries;


@end


#pragma mark - TC5LanguageList
@implementation TC5LanguageList


#pragma mark - synthesize


#pragma mark - class method
+ (TC5LanguageList *)sharedInstance
{
    static dispatch_once_t onceToken;
    static TC5LanguageList *_TC5LanguageList = nil;
    dispatch_once(&onceToken, ^ () {
        _TC5LanguageList = [TC5LanguageList new];
    });
    return _TC5LanguageList;
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
- (NSString *)languageWithLanguage:(NSString *)language
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

- (NSArray *)languageListWithLanguage:(NSString *)language
{
    NSMutableArray *list = [NSMutableArray new];
    for (NSInteger i = 0; i < self.countries.count; i++) {
        [list addObject:[self.countries[i] objectForKey:language]];
    }
    return list;
}

- (NSString *)nativeLanguage
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
    TC5CSV *languageList = [TC5CSV new];
    [languageList loadCSVWithName:@"Language"];
    self.countries = languageList.datas;
}


@end

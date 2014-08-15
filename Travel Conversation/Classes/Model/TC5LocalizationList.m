#import "TC5CSV.h"
#import "TC5LocalizationList.h"


#pragma mark - TC5LocalizationList
@interface TC5LocalizationList ()


@property (nonatomic, strong) NSArray *localizations;


@end


#pragma mark - TC5LocalizationList
@implementation TC5LocalizationList


#pragma mark - synthesize


#pragma mark - class method
+ (TC5LocalizationList *)sharedInstance
{
    static dispatch_once_t onceToken;
    static TC5LocalizationList *_TC5LocalizationList = nil;
    dispatch_once(&onceToken, ^ () {
        _TC5LocalizationList = [TC5LocalizationList new];
    });
    return _TC5LocalizationList;
}


#pragma mark - initializer
- (id)init
{
    self = [super init];
    if (self == nil) { return self; }
    [self createlocalization];

    return self;
}


#pragma mark - dealloc
- (void)dealloc
{
    self.localizations = nil;
}


#pragma mark - api
- (NSArray *)localizationListWithLanguage:(NSString *)language
{
    NSMutableArray *list = [NSMutableArray new];
    for (NSInteger i = 0; i < self.localizations.count; i++) {
        [list addObject:[self.localizations[i] objectForKey:language]];
    }
    return list;
}

- (NSString *)localizationWithEnglishKey:(NSString *)englishKey
{
    NSString *nativeLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage];
    NSArray *nativeLocalizations = [self localizationListWithLanguage:nativeLanguage];
    NSArray *englishLocalizations = [self localizationListWithLanguage:@"en-US"];
    for (NSInteger i = 0; i < englishLocalizations.count; i++) {
        if ([englishLocalizations[i] isEqualToString:englishKey]) {
            return nativeLocalizations[i];
        }
    }
    return nil;
}


#pragma mark - private api
- (void)createlocalization
{
    TC5CSV *localizationList = [TC5CSV new];
    [localizationList loadCSVWithName:@"Localization"];
    self.localizations = localizationList.datas;
}


@end

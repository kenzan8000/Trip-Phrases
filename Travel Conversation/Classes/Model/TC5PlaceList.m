#import "TC5CSV.h"
#import "TC5PlaceList.h"


#pragma mark - TC5PlaceList
@interface TC5PlaceList ()


@property (nonatomic, strong) NSArray *places;


@end


#pragma mark - TC5PlaceList
@implementation TC5PlaceList


#pragma mark - synthesize


#pragma mark - class method
+ (TC5PlaceList *)sharedInstance
{
    static dispatch_once_t onceToken;
    static TC5PlaceList *_TC5PlaceList = nil;
    dispatch_once(&onceToken, ^ () {
        _TC5PlaceList = [TC5PlaceList new];
    });
    return _TC5PlaceList;
}


#pragma mark - initializer
- (id)init
{
    self = [super init];
    if (self == nil) { return self; }
    [self createplace];

    return self;
}


#pragma mark - dealloc
- (void)dealloc
{
    self.places = nil;
}


#pragma mark - api
- (NSArray *)placeListWithLanguage:(NSString *)language
{
    NSMutableArray *list = [NSMutableArray new];
    for (NSInteger i = 0; i < self.places.count; i++) {
        [list addObject:[self.places[i] objectForKey:language]];
    }
    return list;
}


#pragma mark - private api
- (void)createplace
{
    TC5CSV *placeList = [TC5CSV new];
    [placeList loadCSVWithName:@"Place"];
    self.places = placeList.datas;
}


@end

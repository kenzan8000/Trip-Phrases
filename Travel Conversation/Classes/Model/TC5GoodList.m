#import "TC5CSV.h"
#import "TC5GoodList.h"


#pragma mark - TC5GoodList
@interface TC5GoodList ()


@property (nonatomic, strong) NSArray *goods;


@end


#pragma mark - TC5GoodList
@implementation TC5GoodList


#pragma mark - synthesize


#pragma mark - class method
+ (TC5GoodList *)sharedInstance
{
    static dispatch_once_t onceToken;
    static TC5GoodList *_TC5GoodList = nil;
    dispatch_once(&onceToken, ^ () {
        _TC5GoodList = [TC5GoodList new];
    });
    return _TC5GoodList;
}


#pragma mark - initializer
- (id)init
{
    self = [super init];
    if (self == nil) { return self; }
    [self createGood];

    return self;
}


#pragma mark - dealloc
- (void)dealloc
{
    self.goods = nil;
}


#pragma mark - api
- (NSArray *)goodListWithLanguage:(NSString *)language
{
    NSMutableArray *list = [NSMutableArray new];
    for (NSInteger i = 0; i < self.goods.count; i++) {
        [list addObject:[self.goods[i] objectForKey:language]];
    }
    return list;
}


#pragma mark - private api
- (void)createGood
{
    TC5CSV *goodList = [TC5CSV new];
    [goodList loadCSVWithName:@"Good"];
    self.goods = goodList.datas;
}


@end

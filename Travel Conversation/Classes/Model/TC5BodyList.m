#import "TC5CSV.h"
#import "TC5BodyList.h"


#pragma mark - TC5BodyList
@interface TC5BodyList ()


@property (nonatomic, strong) NSArray *bodys;


@end


#pragma mark - TC5BodyList
@implementation TC5BodyList


#pragma mark - synthesize


#pragma mark - class method
+ (TC5BodyList *)sharedInstance
{
    static dispatch_once_t onceToken;
    static TC5BodyList *_TC5BodyList = nil;
    dispatch_once(&onceToken, ^ () {
        _TC5BodyList = [TC5BodyList new];
    });
    return _TC5BodyList;
}


#pragma mark - initializer
- (id)init
{
    self = [super init];
    if (self == nil) { return self; }
    [self createbody];

    return self;
}


#pragma mark - dealloc
- (void)dealloc
{
    self.bodys = nil;
}


#pragma mark - api
- (NSArray *)bodyListWithLanguage:(NSString *)language
{
    NSMutableArray *list = [NSMutableArray new];
    for (NSInteger i = 0; i < self.bodys.count; i++) {
        [list addObject:[self.bodys[i] objectForKey:language]];
    }
    return list;
}


#pragma mark - private api
- (void)createbody
{
    TC5CSV *bodyList = [TC5CSV new];
    [bodyList loadCSVWithName:@"Body"];
    self.bodys = bodyList.datas;
}


@end

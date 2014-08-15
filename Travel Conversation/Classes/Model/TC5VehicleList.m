#import "TC5CSV.h"
#import "TC5VehicleList.h"


#pragma mark - TC5VehicleList
@interface TC5VehicleList ()


@property (nonatomic, strong) NSArray *vehicles;


@end


#pragma mark - TC5VehicleList
@implementation TC5VehicleList


#pragma mark - synthesize


#pragma mark - class method
+ (TC5VehicleList *)sharedInstance
{
    static dispatch_once_t onceToken;
    static TC5VehicleList *_TC5VehicleList = nil;
    dispatch_once(&onceToken, ^ () {
        _TC5VehicleList = [TC5VehicleList new];
    });
    return _TC5VehicleList;
}


#pragma mark - initializer
- (id)init
{
    self = [super init];
    if (self == nil) { return self; }
    [self createvehicle];

    return self;
}


#pragma mark - dealloc
- (void)dealloc
{
    self.vehicles = nil;
}


#pragma mark - api
- (NSArray *)vehicleListWithLanguage:(NSString *)language
{
    NSMutableArray *list = [NSMutableArray new];
    for (NSInteger i = 0; i < self.vehicles.count; i++) {
        [list addObject:[self.vehicles[i] objectForKey:language]];
    }
    return list;
}


#pragma mark - private api
- (void)createvehicle
{
    TC5CSV *vehicleList = [TC5CSV new];
    [vehicleList loadCSVWithName:@"Vehicle"];
    self.vehicles = vehicleList.datas;
}


@end

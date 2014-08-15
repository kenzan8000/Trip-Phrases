#pragma mark - TC5VehicleList
@interface TC5VehicleList : NSObject {
}


#pragma mark - property


#pragma mark - class method
+ (TC5VehicleList *)sharedInstance;


#pragma mark - api
- (NSArray *)vehicleListWithLanguage:(NSString *)language;


@end

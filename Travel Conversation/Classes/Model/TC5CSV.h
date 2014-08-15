#pragma mark - TC5CSV
@interface TC5CSV : NSObject {
}


#pragma mark - property
@property (nonatomic, strong) NSMutableArray *datas;


#pragma mark - api
- (void)loadCSVWithName:(NSString *)name;


@end

#pragma mark - TC5CategoryList
@interface TC5CategoryList : NSObject {
}


#pragma mark - property
@property (nonatomic, strong) NSArray *categories;


#pragma mark - class method
+ (TC5CategoryList *)sharedInstance;


#pragma mark - api


@end

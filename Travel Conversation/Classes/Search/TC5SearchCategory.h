#pragma mark - class
@class TC5Category;


#pragma mark - TC5SearchCategory
@interface TC5SearchCategory : NSObject


#pragma mark - properties
@property (nonatomic, strong) TC5Category *category;
@property (nonatomic, strong) NSArray *conversations;


#pragma mark - api
- (NSString *)categoryName;


@end

#pragma mark - TC5PlaceList
@interface TC5PlaceList : NSObject {
}


#pragma mark - property


#pragma mark - class method
+ (TC5PlaceList *)sharedInstance;


#pragma mark - api
- (NSArray *)placeListWithLanguage:(NSString *)language;


@end

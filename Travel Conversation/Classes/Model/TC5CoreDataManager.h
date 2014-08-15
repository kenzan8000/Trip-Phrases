@class NSManagedObjectModel;
@class NSManagedObjectContext;
@class NSPersistentStoreCoordinator;


#pragma mark - TC5CoreDataManager
@interface TC5CoreDataManager : NSObject {
}


#pragma mark - property
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;


#pragma mark - class method
+ (TC5CoreDataManager *)sharedInstance;


@end

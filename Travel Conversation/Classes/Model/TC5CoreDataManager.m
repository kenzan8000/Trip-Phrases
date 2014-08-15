#import <CoreData/CoreData.h>
#import "TC5CoreDataManager.h"


#pragma mark - TC5CoreDataManager
@implementation TC5CoreDataManager


#pragma mark - class method
+ (TC5CoreDataManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    static TC5CoreDataManager *_TC5CoreDataManager = nil;
    dispatch_once(&onceToken, ^ () {
        _TC5CoreDataManager = [TC5CoreDataManager new];
    });
    return _TC5CoreDataManager;
}


#pragma mark - api
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) { return _managedObjectContext; }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }

    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) { return _managedObjectModel; }

    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TravelConversation" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *storeUrl = [NSURL fileURLWithPath:[documentsDirectory stringByAppendingPathComponent:@"TravelConversation.sqlite"]];

    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeUrl
                                                         options:nil
                                                           error:&error]) {
        abort();
    }

    return _persistentStoreCoordinator;
}


@end

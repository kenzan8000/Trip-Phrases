#import <CoreData/CoreData.h>
#import "TC5CSV.h"
#import "TC5CategoryList.h"
#import "TC5CoreDataManager.h"


#pragma mark - TC5CategoryList
@implementation TC5CategoryList


#pragma mark - synthesize


#pragma mark - class method
+ (TC5CategoryList *)sharedInstance
{
    static dispatch_once_t onceToken;
    static TC5CategoryList *_TC5CategoryList = nil;
    dispatch_once(&onceToken, ^ () {
        _TC5CategoryList = [TC5CategoryList new];
    });
    return _TC5CategoryList;
}


#pragma mark - initializer
- (id)init
{
    self = [super init];
    if (self == nil) { return self; }

    [self createDataBase];

    // category
    NSError *error = nil;
    NSManagedObjectContext *context = [[TC5CoreDataManager sharedInstance] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TC5Category"
                                              inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    self.categories = [context executeFetchRequest:fetchRequest error:&error];

    return self;
}


#pragma mark - dealloc
- (void)dealloc
{
    self.categories = nil;
}


#pragma mark - api


#pragma mark - private api
- (void)createDataBase
{
    NSError *error = nil;
    NSManagedObjectContext *context = [[TC5CoreDataManager sharedInstance] managedObjectContext];

    /* ***** category ***** */
    {
    TC5CSV *categoryDictionares = [TC5CSV new];
    [categoryDictionares loadCSVWithName:@"Category"];
    // delete
    {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TC5Category"
                                              inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];

    NSArray *objects = [context executeFetchRequest:fetchRequest
                                              error:&error];
    for (NSManagedObject *object in objects) {
        [context deleteObject:object];
    }
    }
    // create
    {
    for (NSDictionary *categoryDictionary in categoryDictionares.datas) {
        NSManagedObject *category = [NSEntityDescription insertNewObjectForEntityForName:@"TC5Category"
                                                                  inManagedObjectContext:context];
        for (NSString *key in [categoryDictionary allKeys]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            NSString *methodName = [NSString stringWithFormat:@"set%@%@:",
                [[key substringToIndex:1] uppercaseString],
                [[key stringByReplacingOccurrencesOfString:@"-" withString:@""] substringFromIndex:1]
            ];
            [category performSelector:NSSelectorFromString(methodName)
                           withObject:categoryDictionary[key]];
#pragma clang diagnostic pop
        }
    }
    }
    }

    if (![context save:&error]) { abort(); }
}


@end

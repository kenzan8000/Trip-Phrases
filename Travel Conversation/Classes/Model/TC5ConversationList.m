#import <CoreData/CoreData.h>
#import "TC5CSV.h"
#import "TC5ConversationList.h"
#import "TC5CoreDataManager.h"


#pragma mark - TC5ConversationList
@implementation TC5ConversationList


#pragma mark - synthesize


#pragma mark - class method
+ (TC5ConversationList *)sharedInstance
{
    static dispatch_once_t onceToken;
    static TC5ConversationList *_TC5ConversationList = nil;
    dispatch_once(&onceToken, ^ () {
        _TC5ConversationList = [TC5ConversationList new];
    });
    return _TC5ConversationList;
}


#pragma mark - initializer
- (id)init
{
    self = [super init];
    if (self == nil) { return self; }

    [self createDataBase];

    return self;
}


#pragma mark - dealloc
- (void)dealloc
{
}


#pragma mark - api
- (NSArray *)conversationsWithCategory:(NSString *)category
{
    NSManagedObjectContext *context = [[TC5CoreDataManager sharedInstance] managedObjectContext];

    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TC5Conversation"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    if ([category isEqualToString:@"All phrase"] == NO) {
       [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"SELF.category == %@", category]];
    }
    else {
       NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"category"
                                                                      ascending:YES];
       [fetchRequest setSortDescriptors:@[sortDescriptor]];
    }
    NSError *error = nil;
    NSArray *conversations = [context executeFetchRequest:fetchRequest
                                                    error:&error];
    if (![context save:&error]) { abort(); }
    return conversations;
}


#pragma mark - private api
- (void)createDataBase
{
    NSError *error = nil;
    NSManagedObjectContext *context = [[TC5CoreDataManager sharedInstance] managedObjectContext];

    /* ***** conversation ***** */
    {
    TC5CSV *conversations = [TC5CSV new];
    [conversations loadCSVWithName:@"Conversation"];

    // delete
    {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TC5Conversation"
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
    for (NSDictionary *conversationDictionary in conversations.datas) {
        NSManagedObject *conversation = [NSEntityDescription insertNewObjectForEntityForName:@"TC5Conversation"
                                                                      inManagedObjectContext:context];
        for (NSString *key in [conversationDictionary allKeys]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            NSString *methodName = [NSString stringWithFormat:@"set%@%@:",
                [[key substringToIndex:1] uppercaseString],
                [[key stringByReplacingOccurrencesOfString:@"-" withString:@""] substringFromIndex:1]
            ];
            [conversation performSelector:NSSelectorFromString(methodName)
                               withObject:conversationDictionary[key]];
#pragma clang diagnostic pop
        }
    }
    }
    }

    if (![context save:&error]) { abort(); }
}


@end

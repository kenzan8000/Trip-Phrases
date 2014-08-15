#import "TC5CSV.h"


#pragma mark - TC5CSV
@implementation TC5CSV


#pragma mark - synthesize
@synthesize datas;


#pragma mark - initializer
- (id)init
{
    self = [super init];
    if (self) {
        self.datas = [NSMutableArray new];
    }
    return self;
}


#pragma mark - dealloc
- (void)dealloc
{
    self.datas = nil;
}


#pragma mark - api
- (void)loadCSVWithName:(NSString *)name
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name
                                                         ofType:@"csv"];
    NSString *text = [NSString stringWithContentsOfFile:filePath
                                               encoding:NSUTF8StringEncoding
                                                  error:nil];

    NSArray *lines = [text componentsSeparatedByString:@"\n"];
    NSArray *keys = [lines[0] componentsSeparatedByString:@"	"];

    for (NSInteger i = 1; i < lines.count; i++) {
        NSArray *items = [lines[i] componentsSeparatedByString:@"	"];
        if ([items count] < keys.count) { continue; }

        NSMutableDictionary *dic = [NSMutableDictionary new];
        for (NSInteger j = 0; j < keys.count; j++) {
            NSString *key = keys[j];
            [dic setObject:items[j]
                    forKey:key];
        }

        [self.datas addObject:dic];
    }

}


@end

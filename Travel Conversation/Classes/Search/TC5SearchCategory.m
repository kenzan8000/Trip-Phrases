#import "TC5SearchCategory.h"
#import "TC5Category.h"


#pragma mark - TC5SearchCategory
@implementation TC5SearchCategory


- (NSString *)categoryName
{
    NSString *nativeLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage];
    return [[self.category valueForKey:[nativeLanguage stringByReplacingOccurrencesOfString:@"-" withString:@""]] description];
}


@end



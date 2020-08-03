#import "AppDelegate.h"
#import "UIColor+Hexadecimal.h"
#import "TC5ConversationList.h"


#pragma mark - AppDelegate
@implementation AppDelegate


#pragma mark - life cycle
- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // UI
        // bar color

    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexadecimal:0x34495eff]];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{
        NSForegroundColorAttributeName:[UIColor whiteColor],
    }
                                                                                        forState:UIControlStateNormal];
        // bar title
    NSShadow *shadow = [NSShadow new];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName:[UIColor whiteColor],
NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20.0f],
    }];
    /*
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent
                                                animated:NO];
    */
    // launch count
    NSInteger launchCount = [[NSUserDefaults standardUserDefaults] integerForKey:kUserDefaultsLaunchCount];

    // play speed
    CGFloat speed = [[NSUserDefaults standardUserDefaults] floatForKey:kUserDefaultsPlaySpeed];
    if (speed < kPlaySpeedManimum || speed > kPlaySpeedMaximum) {
        speed = (kPlaySpeedManimum + kPlaySpeedMaximum) / 2.0f;
    }
    [[NSUserDefaults standardUserDefaults] setFloat:speed
                                             forKey:kUserDefaultsPlaySpeed];

    // native language
    if (launchCount == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:@"en-US"
                                                  forKey:kUserDefaultsNativeLanguage];
        [[NSUserDefaults standardUserDefaults] setObject:@"it-IT"
                                                  forKey:kUserDefaultsTranslatedLanguage];
/*
        NSArray *languages = [NSLocale preferredLanguages];
        NSArray *userDefaultsKeys = @[kUserDefaultsNativeLanguage, kUserDefaultsTranslatedLanguage];
        for (NSInteger i = 0; i < userDefaultsKeys.count; i ++) {
            NSString *userDefaultsKey = userDefaultsKeys[i];
            for (NSInteger j = 0; j < kSpeechVoiceLanguages.count; j++) {
                NSString *language = kSpeechVoiceLanguages[j];
                if (language && [language isKindOfClass:[NSString class]] && [language hasPrefix:languages[i]]) {
                    [[NSUserDefaults standardUserDefaults] setObject:language
                                                              forKey:userDefaultsKey];
                }
            }
        }
*/
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:launchCount + 1
                                               forKey:kUserDefaultsLaunchCount];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [TC5ConversationList sharedInstance];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}


@end

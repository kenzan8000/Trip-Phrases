//
//  TC5Conversation.m
//  Travel Conversation
//
//  Created by Kenzan Hase on 7/27/14.
//  Copyright (c) 2014 Kenzan Hase. All rights reserved.
//

#import "TC5Conversation.h"
#import "TC5CountryList.h"
#import "TC5GoodList.h"
#import "TC5PlaceList.h"
#import "TC5VehicleList.h"
#import "TC5BodyList.h"
#import "TC5LanguageList.h"


@implementation TC5Conversation

@dynamic arSA;
@dynamic category;
@dynamic csCZ;
@dynamic daDK;
@dynamic deDE;
@dynamic elGR;
@dynamic enAU;
@dynamic enGB;
@dynamic enIE;
@dynamic enUS;
@dynamic enZA;
@dynamic esES;
@dynamic esMX;
@dynamic fiFI;
@dynamic frCA;
@dynamic frFR;
@dynamic huHU;
@dynamic idID;
@dynamic itIT;
@dynamic jaJP;
@dynamic koKR;
@dynamic nlBE;
@dynamic nlNL;
@dynamic noNO;
@dynamic plPL;
@dynamic ptBR;
@dynamic ptPT;
@dynamic roRO;
@dynamic ruRU;
@dynamic skSK;
@dynamic svSE;
@dynamic thTH;
@dynamic trTR;
@dynamic zhCN;
@dynamic zhHK;
@dynamic zhTW;


#pragma mark - public api
- (NSString *)translatedText
{
    NSString *language = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsTranslatedLanguage];
    NSString *text = [[self valueForKey:[language stringByReplacingOccurrencesOfString:@"-" withString:@""]] description];
    return text;
}

- (NSString *)nativeText
{
    NSString *language = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage];
    NSString *text = [[self valueForKey:[language stringByReplacingOccurrencesOfString:@"-" withString:@""]] description];
    return text;
}

- (NSString *)translatedTextWithListIndex:(NSInteger)listIndex
{
    NSString *translatedLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsTranslatedLanguage];
    return [self replacedTextWithListIndex:listIndex language:translatedLanguage];
}

- (NSString *)nativeTextWithListIndex:(NSInteger)listIndex
{
    NSString *nativeLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage];
    return [self replacedTextWithListIndex:listIndex language:nativeLanguage];
}

- (NSString *)nativeTitleText
{
    NSString *language = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage];
    NSString *text = [[self valueForKey:[language stringByReplacingOccurrencesOfString:@"-" withString:@""]] description];

    NSArray *lists = @[
        @"%country", @"%good", @"%number", @"%place", @"%vehicle", @"%body", @"%language",
    ];

    for (NSInteger i = 0; i < lists.count; i++) {
        NSString *replaceString = @"○○○";
        NSString *after = [text stringByReplacingOccurrencesOfString:lists[i]
                                                          withString:replaceString];
        if ([text isEqualToString:after]) { continue; }
        text = after;
    }

    return text;
}

- (NSArray *)replacementStringsWithListIndex:(NSInteger)listIndex
{
    NSMutableArray *strings = [NSMutableArray new];

    NSString *translatedLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsTranslatedLanguage];
    NSString *nativeLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage];
    NSArray *languages = @[translatedLanguage, nativeLanguage];

    NSArray *lists = @[
        @"%country", @"%good", @"%number", @"%place", @"%vehicle", @"%body", @"%language",
    ];

    for (NSInteger j = 0; j < languages.count; j++) {

    NSString *text = [[self valueForKey:[languages[j] stringByReplacingOccurrencesOfString:@"-" withString:@""]] description];
    NSString *language = languages[j];
    NSArray *array = nil;
    for (NSInteger i = 0; i < lists.count; i++) {
        NSString *replaceString = @"";
        switch (i) {
            case 0:
                array = [[TC5CountryList sharedInstance] countryListWithLanguage:language];
                break;
            case 1:
                array = [[TC5GoodList sharedInstance] goodListWithLanguage:language];
                break;
            case 2:
                break;
            case 3:
                array = [[TC5PlaceList sharedInstance] placeListWithLanguage:language];
                break;
            case 4:
                array = [[TC5VehicleList sharedInstance] vehicleListWithLanguage:language];
                break;
            case 5:
                array = [[TC5BodyList sharedInstance] bodyListWithLanguage:language];
                break;
            case 6:
                array = [[TC5LanguageList sharedInstance] languageListWithLanguage:language];
                break;
        }
        switch (i) {
            case 2:
                replaceString = [NSString stringWithFormat:@"%ld", listIndex+1];
                break;
            default:
                if (listIndex < [array count]) {
                    replaceString = [array objectAtIndex:listIndex];
                }
                break;
        }
        NSString *after = [text stringByReplacingOccurrencesOfString:lists[i]
                                                          withString:replaceString];
        if ([text isEqualToString:after]) { continue; }
        [strings addObject:replaceString];
    }

    }

    return strings;
}

- (NSArray *)replacementList
{
    NSArray *lists = @[
        @"%country", @"%good", @"%number", @"%place", @"%vehicle", @"%body", @"%language",
    ];

    NSString *language = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsNativeLanguage];
    NSString *text = [[self valueForKey:[language stringByReplacingOccurrencesOfString:@"-" withString:@""]] description];
    for (NSInteger i = 0; i < lists.count; i++) {
        NSArray *array = nil;
        switch (i) {
            case 0:
                array = [[TC5CountryList sharedInstance] countryListWithLanguage:language];
                break;
            case 1:
                array = [[TC5GoodList sharedInstance] goodListWithLanguage:language];
                break;
            case 2:
                array = @[
                    @"1",  @"2",  @"3",  @"4",  @"5",  @"6",  @"7",
                    @"8",  @"9",  @"10", @"11", @"12", @"13", @"14", @"15",
                    @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24",
                ];
                break;
            case 3:
                array = [[TC5PlaceList sharedInstance] placeListWithLanguage:language];
                break;
            case 4:
                array = [[TC5VehicleList sharedInstance] vehicleListWithLanguage:language];
                break;
            case 5:
                array = [[TC5BodyList sharedInstance] bodyListWithLanguage:language];
                break;
            case 6:
                array = [[TC5LanguageList sharedInstance] languageListWithLanguage:language];
                break;
        }
        NSString *after = [text stringByReplacingOccurrencesOfString:lists[i]
                                                          withString:@""];
        if ([text isEqualToString:after]) { continue; }
        return array;
    }

    NSString *native = [self nativeText];
    BOOL pickable = ([native rangeOfString:@":"].length);
    if (pickable) { return [native componentsSeparatedByString:@":"]; }
    return nil;
}

- (UIImage *)image
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"Category_%@.png", self.category]];
}


#pragma mark - private api
- (NSString *)replacedTextWithListIndex:(NSInteger)listIndex
                               language:(NSString *)language
{
    NSString *text = [[self valueForKey:[language stringByReplacingOccurrencesOfString:@"-" withString:@""]] description];

    NSArray *lists = @[
        @"%country", @"%good", @"%number", @"%place", @"%vehicle", @"%body", @"%language",
    ];

    for (NSInteger i = 0; i < lists.count; i++) {
        NSString *replaceString = @"";
        NSArray *array = nil;
        switch (i) {
            case 0:
                array = [[TC5CountryList sharedInstance] countryListWithLanguage:language];
                break;
            case 1:
                array = [[TC5GoodList sharedInstance] goodListWithLanguage:language];
                break;
            case 2:
                break;
            case 3:
                array = [[TC5PlaceList sharedInstance] placeListWithLanguage:language];
                break;
            case 4:
                array = [[TC5VehicleList sharedInstance] vehicleListWithLanguage:language];
                break;
            case 5:
                array = [[TC5BodyList sharedInstance] bodyListWithLanguage:language];
                break;
            case 6:
                array = [[TC5LanguageList sharedInstance] languageListWithLanguage:language];
                break;
        }
        switch (i) {
            case 2:
                replaceString = [NSString stringWithFormat:@"%ld", listIndex+1];
                break;
            default:
                if (listIndex < [array count]) {
                    replaceString = [array objectAtIndex:listIndex];
                }
                break;
        }

        NSString *after = [text stringByReplacingOccurrencesOfString:lists[i]
                                                          withString:replaceString];
        if ([text isEqualToString:after]) { continue; }
        text = after;
    }

    return text;
}


@end

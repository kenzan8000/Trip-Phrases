//
//  TC5Conversation.h
//  Travel Conversation
//
//  Created by Kenzan Hase on 7/27/14.
//  Copyright (c) 2014 Kenzan Hase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TC5Conversation : NSManagedObject

@property (nonatomic, retain) NSString * arSA;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * csCZ;
@property (nonatomic, retain) NSString * daDK;
@property (nonatomic, retain) NSString * deDE;
@property (nonatomic, retain) NSString * elGR;
@property (nonatomic, retain) NSString * enAU;
@property (nonatomic, retain) NSString * enGB;
@property (nonatomic, retain) NSString * enIE;
@property (nonatomic, retain) NSString * enUS;
@property (nonatomic, retain) NSString * enZA;
@property (nonatomic, retain) NSString * esES;
@property (nonatomic, retain) NSString * esMX;
@property (nonatomic, retain) NSString * fiFI;
@property (nonatomic, retain) NSString * frCA;
@property (nonatomic, retain) NSString * frFR;
@property (nonatomic, retain) NSString * huHU;
@property (nonatomic, retain) NSString * idID;
@property (nonatomic, retain) NSString * itIT;
@property (nonatomic, retain) NSString * jaJP;
@property (nonatomic, retain) NSString * koKR;
@property (nonatomic, retain) NSString * nlBE;
@property (nonatomic, retain) NSString * nlNL;
@property (nonatomic, retain) NSString * noNO;
@property (nonatomic, retain) NSString * plPL;
@property (nonatomic, retain) NSString * ptBR;
@property (nonatomic, retain) NSString * ptPT;
@property (nonatomic, retain) NSString * roRO;
@property (nonatomic, retain) NSString * ruRU;
@property (nonatomic, retain) NSString * skSK;
@property (nonatomic, retain) NSString * svSE;
@property (nonatomic, retain) NSString * thTH;
@property (nonatomic, retain) NSString * trTR;
@property (nonatomic, retain) NSString * zhCN;
@property (nonatomic, retain) NSString * zhHK;
@property (nonatomic, retain) NSString * zhTW;

- (NSString *)translatedText;
- (NSString *)nativeText;
- (NSString *)translatedTextWithListIndex:(NSInteger)listIndex;
- (NSString *)nativeTextWithListIndex:(NSInteger)listIndex;
- (NSString *)nativeTitleText;
- (NSArray *)replacementStringsWithListIndex:(NSInteger)listIndex;
- (NSArray *)replacementList;
- (UIImage *)image;

@end

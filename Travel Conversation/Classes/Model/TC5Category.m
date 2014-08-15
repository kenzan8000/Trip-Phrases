//
//  TC5Category.m
//  Travel Conversation
//
//  Created by Kenzan Hase on 7/27/14.
//  Copyright (c) 2014 Kenzan Hase. All rights reserved.
//

#import "TC5Category.h"


@implementation TC5Category

@dynamic zhTW;
@dynamic zhHK;
@dynamic zhCN;
@dynamic trTR;
@dynamic thTH;
@dynamic svSE;
@dynamic skSK;
@dynamic ruRU;
@dynamic roRO;
@dynamic ptPT;
@dynamic ptBR;
@dynamic plPL;
@dynamic noNO;
@dynamic nlNL;
@dynamic nlBE;
@dynamic koKR;
@dynamic jaJP;
@dynamic itIT;
@dynamic idID;
@dynamic huHU;
@dynamic frFR;
@dynamic frCA;
@dynamic fiFI;
@dynamic esMX;
@dynamic esES;
@dynamic enZA;
@dynamic enUS;
@dynamic enIE;
@dynamic enGB;
@dynamic enAU;
@dynamic elGR;
@dynamic deDE;
@dynamic daDK;
@dynamic csCZ;
@dynamic arSA;

- (UIImage *)image
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"Category_%@.png", self.enUS]];
}

@end

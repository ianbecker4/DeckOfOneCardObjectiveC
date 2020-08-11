//
//  DVMCard.m
//  DeckOfCardsObjectiveC
//
//  Created by Marcus Armstrong on 11/15/19.
//  Copyright © 2019 Marcus Armstrong. All rights reserved.
//

#import "DVMCard.h"

static NSString * const suitKey = @"suit";
static NSString * const imageKey = @"image";

@implementation DVMCard

- (instancetype)initWithSuit:(NSString *)suit imageString:(NSString *)imageString;
{
    if (self = [super init])
    {
        _suit = suit;
        _imageString = imageString;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *suit = dictionary[suitKey];
    NSString *imageString = dictionary[imageKey];
    
    return [self initWithSuit:suit imageString:imageString];
}
@end

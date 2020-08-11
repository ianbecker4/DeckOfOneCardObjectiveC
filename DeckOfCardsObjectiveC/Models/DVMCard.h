//
//  DVMCard.h
//  DeckOfCardsObjectiveC
//
//  Created by Marcus Armstrong on 11/15/19.
//  Copyright © 2019 Marcus Armstrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVMCard : NSObject

@property (nonatomic, copy, readonly) NSString *suit;

@property (nonatomic, copy, readonly) NSString *imageString;

- (instancetype)initWithSuit:(NSString *)suit imageString:(NSString *)imageString;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

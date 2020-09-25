//
//  DVMCardController.h
//  DeckOfCardsObjectiveC
//
//  Created by Marcus Armstrong on 11/15/19.
//  Copyright © 2019 Marcus Armstrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DVMCard;

NS_ASSUME_NONNULL_BEGIN

@interface DVMCardController : NSObject

//+ (instancetype)sharedInstance;

+ (void)drawANewCard:(NSNumber *)numberOfCards
          completion:(void(^) (NSArray<DVMCard *> * _Nullable cards))completion;

+ (void)fetchCardImage:(DVMCard *)card
            completion:(void(^) (UIImage * _Nullable image))completion;

@end

NS_ASSUME_NONNULL_END

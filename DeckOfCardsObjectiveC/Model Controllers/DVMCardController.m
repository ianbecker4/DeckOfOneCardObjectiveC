//
//  DVMCardController.m
//  DeckOfCardsObjectiveC
//
//  Created by Marcus Armstrong on 11/15/19.
//  Copyright © 2019 Marcus Armstrong. All rights reserved.
//

#import "DVMCardController.h"
#import "DVMCard.h"

static NSString * const baseURLString = @"https://deckofcardsapi.com/api/deck/new/";
static NSString * const drawComponent = @"draw/";
static NSString * const countQueryName = @"count";
static NSString * const cardsArrayKey = @"cards";

@implementation DVMCardController

//+ (instancetype)sharedInstance
//{
//    static DVMCardController * sharedInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^ {
//        sharedInstance = [DVMCardController new];
//    });
//
//    return sharedInstance;
//}

+ (void)drawANewCard:(NSNumber *)numberOfCards completion:(void (^)(NSArray<DVMCard *> * _Nullable))completion{
    NSURL * baseURL = [NSURL URLWithString:baseURLString];
    NSURL * drawURL = [baseURL URLByAppendingPathComponent:drawComponent];
    NSString * cardCount = [numberOfCards stringValue];
    NSURLComponents * urlComponents = [NSURLComponents componentsWithURL:drawURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:countQueryName value:cardCount];
    urlComponents.queryItems = @[queryItem];
    NSURL *searchURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error fetching card from url: %@", error);
            completion(nil); return;
        }
        
        if (!data)
        {
            NSLog(@"Error fetching card data from url: %@", error);
            completion(nil); return;
        }
        
        NSDictionary * jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"Error fetching and decoding the JSON dictionary");
            completion(nil);
            return;
        }
        
        NSArray * cardsArray = jsonDictionary[cardsArrayKey];
        
        NSMutableArray * cardsPlaceholder = [NSMutableArray array];
        
        for (NSDictionary * cardDictionary in cardsArray)
        {
            DVMCard *card = [[DVMCard alloc] initWithDictionary: cardDictionary];
            [cardsPlaceholder addObject: card];
        }
        completion(cardsPlaceholder);
    }]resume];
}

+ (void)fetchCardImage:(DVMCard *)card completion:(void (^)(UIImage * _Nullable))completion{
    
    NSURL * imageURL = [NSURL URLWithString:card.imageString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error fetching card image from url: %@", error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"Error fetching card image data from url: %@", error);
            completion(nil);
            return;
        }
        
        UIImage *cardImage = [UIImage imageWithData:data];
        completion(cardImage);
    }]resume];
}
@end

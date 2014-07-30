//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by キバ on 7/12/14.
//  Copyright (c) 2014 Kiba & Akamaru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject
@property (nonatomic, readonly) NSInteger score; // readonly means no setter
@property (nonatomic) NSUInteger maxMatchingCards;
@property (nonatomic, readonly) NSArray *lastChosenCards;
@property (nonatomic, readonly) NSInteger lastScore;

// Designated initializer
- (instancetype) initWithCardCount: (NSUInteger) count
                         usingDeck: (Deck *) deck;

- (void) chooseCardAtIndex: (NSUInteger) index;
- (Card *) cardAtIndex: (NSUInteger) index;

@end
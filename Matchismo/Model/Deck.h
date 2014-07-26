//
//  Deck.h
//  Matchismo
//
//  Created by キバ on 7/10/14.
//  Copyright (c) 2014 Kiba & Akamaru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard: (Card *) card atTop: (BOOL) atTop;
- (void) addCard: (Card *) card;

- (Card *) drawRandomCard;

@end
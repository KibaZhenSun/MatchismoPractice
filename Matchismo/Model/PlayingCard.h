//
//  PlayingCard.h
//  Matchismo
//
//  Created by キバ on 7/10/14.
//  Copyright (c) 2014 Kiba & Akamaru. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end
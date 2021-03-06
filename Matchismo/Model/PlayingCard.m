//
//  PlayingCard.m
//  Matchismo
//
//  Created by キバ on 7/10/14.
//  Copyright (c) 2014 Kiba & Akamaru. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

/************************************************************************
 
                       This is the original method
 
- (int) match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1)
    {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank)
        {
            score = 4;
        }
        else if ([otherCard.suit isEqualToString: self.suit])
        {
            score = 1;
        }
    }
    
    return score;
}

**************************************************************************/

- (int) match: (NSArray *)otherCards
{
    int score = 0;
    NSUInteger numOtherCards = [otherCards count];
    
    if (numOtherCards)
    {
        for (Card *card in otherCards)
        {
            if ([card isKindOfClass: [PlayingCard class]])
            {
                PlayingCard *otherCard = (PlayingCard *) card;
                if ([self.suit isEqualToString: otherCard.suit])
                {
                    score += 1;
                }
                else if (self.rank == otherCard.rank)
                {
                    score += 4;
                }
            }
        }
    }
    
    // Recursive match method. Awesome!
    if (numOtherCards > 1)
    {
        score += [[otherCards firstObject] match:
                  [otherCards subarrayWithRange: NSMakeRange(1, numOtherCards - 1)]];
    }
    
    return score;
}

- (NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString: self.suit];
}

@synthesize suit = _suit;

+ (NSArray *) validSuits
{
    return @[@"♠️", @"♥️", @"♣️", @"♦️"];
}

- (void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject: suit])
    {
        _suit = suit;
    }
}

- (NSString *) suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *) rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8",
             @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank
{
    return [[PlayingCard rankStrings] count] - 1;
}

- (void) setRank: (NSUInteger) rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end
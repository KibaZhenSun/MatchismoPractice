//
//  CardGameViewController.m
//  Matchismo
//
//  Created by キバ on 7/9/14.
//  Copyright (c) 2014 Kiba & Akamaru. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (weak, nonatomic) IBOutlet UILabel *flipDescription;

@end

@implementation CardGameViewController

- (CardMatchingGame *) game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount: [self.cardButtons count]
                                                  usingDeck: [self createDeck]];
        [self changeModeSelector: self.modeSelector];
    }
    return _game;
}

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    self.modeSelector.enabled = NO;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject: sender];
    [self.game chooseCardAtIndex: chosenButtonIndex];
    [self updateUI];
}

// Made this change to Restart the game
- (IBAction)touchDealButton:(id)sender
{
    self.modeSelector.enabled = YES;
    self.game = nil;
    [self updateUI];
}

- (IBAction)changeModeSelector:(UISegmentedControl *)sender
{
    self.game.maxMatchingCards = [[sender titleForSegmentAtIndex:
                                   sender.selectedSegmentIndex] integerValue];
    // NSLog(@"Mode: %d", self.game.maxMatchingCards);
}


/************************************************************************************************
 
                        This is the original method
 
- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject: cardButton];
        Card *card = [self.game cardAtIndex: cardButtonIndex];
        [cardButton setTitle: [self titleForCard: card]
                    forState: UIControlStateNormal];
        [cardButton setBackgroundImage: [self backgroundImageForCard: card]
                              forState: UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat: @"Score: %ld", (long)self.game.score];
    }
}
 
*************************************************************************************************/

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject: cardButton];
        Card *card = [self.game cardAtIndex: cardButtonIndex];
        [cardButton setTitle: [self titleForCard: card]
                    forState: UIControlStateNormal];
        [cardButton setBackgroundImage: [self backgroundImageForCard: card]
                              forState: UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat: @"Score: %ld", (long)self.game.score];
    
    if (self.game)
    {
        NSString *description = @"";
        if ([self.game.lastChosenCards count])
        {
            NSMutableArray *cardContents = [NSMutableArray array];
            for (Card *card in self.game.lastChosenCards)
            {
                [cardContents addObject: card.contents];
            }
            description = [cardContents componentsJoinedByString: @" "];
        }
        
        if (self.game.lastScore > 0)
        {
            description = [NSString stringWithFormat: @"Matched %@ for %d points.",
                           description, self.game.lastScore];
        }
        else if (self.game.lastScore < 0)
        {
            description = [NSString stringWithFormat: @"%@ don't match. %d points penalty.",
                           description, -self.game.lastScore];
        }
        
        self.flipDescription.text = description;
    }
}

- (NSString *)titleForCard: (Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *)card
{
    return [UIImage imageNamed: card.isChosen ? @"cardFront" : @"cardBack"];
}


@end

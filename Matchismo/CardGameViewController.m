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

@end

@implementation CardGameViewController

- (CardMatchingGame *) game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount: [self.cardButtons count]
                                                  usingDeck: [self createDeck]];
    }
    return _game;
}

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject: sender];
    [self.game chooseCardAtIndex: chosenButtonIndex];
    [self updateUI];
}

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

- (NSString *)titleForCard: (Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *)card
{
    return [UIImage imageNamed: card.isChosen ? @"cardFront" : @"cardBack"];
}


@end

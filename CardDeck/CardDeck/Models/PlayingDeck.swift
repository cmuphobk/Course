//
//  PlayingDeck.swift
//  CardDeck
//
//  Created by Кирилл Смирнов on 10/04/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import Foundation


struct PlayingDeck {
    private(set) var cards = [PlayingCard]()
    
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                self.cards.append(PlayingCard(suit: suit, rank: rank) )
            }
        }
    }
    
    mutating func draw() -> PlayingCard? {
        if cards.count == 0 { return nil }
        return self.cards.remove(at: self.cards.count.arc4random)
    }
}

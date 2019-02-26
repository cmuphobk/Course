//
//  Concentration.swift
//  Concetration
//
//  Created by Кирилл Смирнов on 20/02/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import Foundation


class Concentration {
    
    var cards: [Card]
    
    var indexOfOneAndOnlyFaceUp: Int?
    
    init(numberPairsOfCard: Int) {
        self.cards = [Card]()
        for _ in 0..<numberPairsOfCard {
            let card = Card(identifier: 0)
            self.cards += [card, card]
        }
        //TODO: перемешать карты
    }
    
    func chooseCard(at index: Int) {
        
        //Если уже помечена как совпавшая
        if !self.cards[index].isMatched {
            
            //Если уже есть индекс пердыдушей выбранной и это эта карта не онаже
            if let matchIndex = self.indexOfOneAndOnlyFaceUp, matchIndex != index {
                
                if self.cards[matchIndex].identifier == self.cards[index].identifier {
                    self.cards[matchIndex].isMatched = true
                    self.cards[index].isMatched = true
                }

                self.cards[index].isFaceUp = true
                self.indexOfOneAndOnlyFaceUp = nil
                
            } else {
                
                //Если обе перевернуты или ни одной
                
                for flipDownIndex in self.cards.indices {
                    self.cards[flipDownIndex].isFaceUp = false
                }
                
                self.cards[index].isFaceUp = true
                self.indexOfOneAndOnlyFaceUp = index
            }
            
            
        }
        
    }
    
}

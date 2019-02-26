//
//  Concentration.swift
//  Concetration
//
//  Created by Кирилл Смирнов on 20/02/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUp: Int?
    
    func chooseCard(at index: Int) {
        
        if !self.cards[index].isMatched {
            
            if let matchIndex = self.indexOfOneAndOnlyFaceUp, matchIndex != index {
                //Если у нас есть предыдущий выбор и его индекс не совпадает с нашим новыми
                if self.cards[matchIndex].identifier == self.cards[index].identifier {
                    self.cards[matchIndex].isMatched = true
                    self.cards[index].isMatched = true
                }
                self.cards[index].isFaceUp = true
                self.indexOfOneAndOnlyFaceUp = nil
                
            } else {
                //Если обе карты перевернуты или не одной
                for flipDownIndex in self.cards.indices {
                    self.cards[flipDownIndex].isFaceUp = false
                }
                self.cards[index].isFaceUp = true
                self.indexOfOneAndOnlyFaceUp = index
                
            }
            
            
        }
        
    }
    
    init(numberPairsOfCards: Int) {
        
        for _ in 0..<numberPairsOfCards {
            let card = Card()
            self.cards += [card, card]
        }
        //TODO: перемешать карты
        
    }
}

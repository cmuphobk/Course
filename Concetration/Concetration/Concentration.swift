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
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        
        //проверяем не сопало ли уже
        if !self.cards[index].isMatched {
            //если перевернутая карта есть и она не та, на которую нажали только что
            if let matchIndex = self.indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //проверяем если identifier перевернутой сейчас и до этого совпали
                if self.cards[matchIndex].identifier == self.cards[index].identifier {
                    self.cards[matchIndex].isMatched = true
                    self.cards[index].isMatched = true
                }
                self.cards[index].isFaceUp = true
                self.indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //если нет карт или две карты лицом вверх
                for flipDownIndex in self.cards.indices {
                    self.cards[flipDownIndex].isFaceUp = false
                }
                self.cards[index].isFaceUp = true
                self.indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    init(numberOfPairsOfCards: Int) {
        self.cards =  [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            self.cards += [card, card]
        }
        //TODO: перемешать карты
    }
    
}

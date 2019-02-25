//
//  Concentration.swift
//  Concetration
//
//  Created by Кирилл Смирнов on 25/02/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        
        //Если уже не совпавшие
        if !self.cards[index].isMatched {
            
            //Если есть предыдущи индекс и он не равен новому
            if let matchIndex = self.indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //Если индексы перевернутой и текущей совпадают, матчим их
                if self.cards[matchIndex].identifier == self.cards[index].identifier {
                    self.cards[matchIndex].isMatched = true
                    self.cards[index].isMatched = true
                }
                //Текущую переварачиваем
                self.cards[index].isFaceUp = true
                self.indexOfOneAndOnlyFaceUpCard = nil
                
            } else {
                //Если обе перевернуты или ни одной
                for flipDownIndex in self.cards.indices {
                    self.cards[flipDownIndex].isFaceUp = false
                }
                self.cards[index].isFaceUp = true
                self.indexOfOneAndOnlyFaceUpCard = index
            }
            
        }

    }
    
    init(numberOfPairsCard: Int) {
        for _ in 0..<numberOfPairsCard {
            let card = Card()
            self.cards += [card, card]
        }
        //TODO: Перемешать карты
    }
    
}

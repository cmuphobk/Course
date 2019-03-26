//
//  Concentration.swift
//  Concetration
//
//  Created by Кирилл Смирнов on 25/02/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return self.cards.indices.filter { self.cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in self.cards.indices {
                self.cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        
        assert(self.cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): выбранный индекс не совпадает с картами")
        
        //Если уже не совпавшие
        if !self.cards[index].isMatched {
            
            //Если есть предыдущи индекс и он не равен новому
            if let matchIndex = self.indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //Если индексы перевернутой и текущей совпадают, матчим их
                if self.cards[matchIndex] == self.cards[index] {
                    self.cards[matchIndex].isMatched = true
                    self.cards[index].isMatched = true
                }
                //Текущую переварачиваем
                self.cards[index].isFaceUp = true
                
            } else {
                self.indexOfOneAndOnlyFaceUpCard = index
            }
            
        }

    }
    
    init(numberOfPairsCard: Int) {
        
        assert(numberOfPairsCard > 0, "Количество пар карт, должно быть больше 0")
        
        for _ in 0..<numberOfPairsCard {
            let card = Card()
            self.cards += [card, card]
        }
        //TODO: Перемешать карты
    }
    
}

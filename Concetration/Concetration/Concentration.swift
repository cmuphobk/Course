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
    
    init(numberPairsOfCard: Int) {
        self.cards = [Card]()
        for _ in 0..<numberPairsOfCard {
            let card = Card(identifier: 0)
            self.cards += [card, card]
        }
        //TODO: перемешать карты
    }
    
    func chooseCard(at index: Int) {
        
    }
    
}

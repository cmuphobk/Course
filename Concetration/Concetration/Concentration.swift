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
    
    func chooseCard(at index: Int) {
        
        
    }
    
    init(numberPairsOfCards: Int) {
        
        for _ in 0..<numberPairsOfCards {
            let card = Card()
            self.cards += [card, card]
        }
        //TODO: перемешать карты
        
    }
}

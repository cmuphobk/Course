//
//  Card.swift
//  Concetration
//
//  Created by Кирилл Смирнов on 20/02/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identiferFactory = 0
    static func getUniqueIdentifier() -> Int {
        Card.identiferFactory += 1
        return Card.identiferFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}

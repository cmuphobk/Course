//
//  Int+Random.swift
//  Concetration
//
//  Created by Кирилл Смирнов on 06/03/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import Foundation


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}



//
//  Collection+OneAndOnly.swift
//  Concetration
//
//  Created by Кирилл Смирнов on 26/03/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import Foundation

extension Collection {
    
    var oneAndOnly: Element? {
        return self.count == 1 ? self.first : nil
    }
    
}

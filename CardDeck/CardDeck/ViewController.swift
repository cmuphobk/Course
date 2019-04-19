//
//  ViewController.swift
//  CardDeck
//
//  Created by Кирилл Смирнов on 10/04/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private(set) var deck = PlayingDeck()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for _ in 1...10 {
            if let card = self.deck.draw() {
                print("\(card)")
            }
        }
    }


}


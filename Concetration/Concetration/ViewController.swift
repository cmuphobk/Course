//
//  ViewController.swift
//  Concetration
//
//  Created by Кирилл Смирнов on 12/02/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import UIKit

enum Emoji: String, CaseIterable {
    case smile = "😀"
    case cry = "😭"
    case scream = "😱"
    case angel = "😇"
    case tease = "😛"
    case love = "😍"
    case cool = "😎"
    case botan = "🤓"
}

class ViewController: UIViewController {
    
    private let countLabelText = "Счетчик нажатий:"
    
    private(set) var count = 0 {
        didSet {
            self.countLabel.text = "\(countLabelText) \(self.count)"
        }
    }
    
    private lazy var game = Concentration(numberOfPairsCard: self.numberOfPairsCard)
    
    var numberOfPairsCard: Int {
        return (self.cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var emojiArray: [Emoji] = Emoji.allCases
    private var emoji: [Card: Emoji] = [:]
    
    @IBOutlet private weak var countLabel: UILabel!
    
    @IBAction private func emojiButtonAction(_ sender: UIButton) {
        
        if let index = self.cardButtons.firstIndex(of: sender) {
            self.game.chooseCard(at: index)
            self.updateViewModel()
        } else {
            print("Unhandled Error!!!")
        }
        
    }
    
    private func updateViewModel() {
        for index in self.cardButtons.indices {
            let button = self.cardButtons[index]
            let card = self.game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(self.emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.6910475492, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.6910475492, blue: 0, alpha: 1)
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if self.emoji[card] == nil, self.emojiArray.count > 0 {
            self.emoji[card] = self.emojiArray.remove(at: self.emojiArray.count.arc4random)
        }
        
        return self.emoji[card]?.rawValue ?? "?"
    }
    
}

//
//  ViewController.swift
//  Concetration
//
//  Created by Кирилл Смирнов on 12/02/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import UIKit

protocol All {
    static var all: String { get }
}

enum EmojiPackStandart: String, CaseIterable, All {
    case smile = "😀"
    case cool = "😎"
    case angel = "😇"
    case love = "😍"
    case botan = "🤓"
   
    static var all: String {
        return self.allCases.map{ $0.rawValue }.joined()
    }
}

enum EmojiPackHaloween: String, CaseIterable, All {
    case smile = "👿"
    case cool = "👹"
    case angel = "🤖"
    case love = "👽"
    case botan = "🎃"
    
    static var all: String {
        return self.allCases.map{ $0.rawValue }.joined()
    }
}

class ViewController: UIViewController {
    
    private let countLabelText = "Счетчик нажатий:"
    
    private(set) var count = 0 {
        didSet {
            self.configLabel(countLabelText: self.countLabelText, count: self.count, label: self.countLabel)
        }
    }
    
    private lazy var game: Concentration = { (numberOfPairsCard: Int) -> (Concentration) in
        return Concentration(numberOfPairsCard: numberOfPairsCard)
    }(self.numberOfPairsCard)
    
    var numberOfPairsCard: Int {
        return (self.cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var themeArray: [All.Type] = [EmojiPackStandart.self, EmojiPackHaloween.self]
    
    private lazy var emojiArray: String = self.themeArray[self.themeArray.count.arc4random].all
    private var emoji: [Card: String] = [:]
    
    @IBOutlet private weak var countLabel: UILabel! {
        didSet {
            self.configLabel(countLabelText: self.countLabelText, count: self.count, label: self.countLabel)
        }
    }
    
    @IBAction private func emojiButtonAction(_ sender: UIButton) {
        
        self.count += 1
        
        if let index = self.cardButtons.firstIndex(of: sender) {
            self.game.chooseCard(at: index)
            self.updateViewModel()
        } else {
            print("Unhandled Error!!!")
        }
        
    }
    
    private func configLabel(countLabelText: String, count: Int, label: UILabel) {
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeColor: UIColor.orange,
            .strokeWidth: 5.0
        ]
        let attributedString = NSAttributedString(string: "\(countLabelText) \(count)", attributes: attributes)
        label.attributedText = attributedString
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
            self.emoji[card] = String(self.emojiArray.remove(at: self.emojiArray.index(self.emojiArray.startIndex, offsetBy: self.emojiArray.count.arc4random)))
        }
        
        return self.emoji[card] ?? "?"
    }
    
}

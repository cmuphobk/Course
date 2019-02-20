//
//  ViewController.swift
//  Concetration
//
//  Created by Кирилл Смирнов on 12/02/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import UIKit

enum Emoji: String {
    case smile = "😀"
    case cry = "😭"
    case scream = "😱"
}

class ViewController: UIViewController {
    
    private let countLabelText = "Счетчик нажатий:"
    private var count = 0
    
    @IBOutlet var cardButtons: [UIButton]!
    
    let emojiArray: [Emoji] = [.smile, .cry, .scream]
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBAction func emojiButtonAction(_ sender: UIButton) {
        
        if let index = self.cardButtons.firstIndex(of: sender) {
            let emoji = self.emojiArray[index]
            self.flipCard(withEmoji: emoji.rawValue, on: sender)
        } else {
            print("Unhandled Error!!!")
        }
        
        
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        
        self.count += 1
        
        self.countLabel.text = "\(countLabelText) \(self.count)"
        
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.6910475492, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
    }
    
}

//
//  ViewController.swift
//  Concentration
//
//  Created by Jiahao Lu on 6/27/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    var numberOfPairsOfCards: Int{
        return (cardButtons.count+1) / 2
    }
    
    private(set) var flipCount:Int = 0{
        didSet{ //property observer
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flip:\(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private(set) var score:Int = 0{
        didSet{
            scoreLabel.text = "Score:\(score)"
        }
    }
    
    var emojiChoice = "🏳️‍🌈🇺🇸🇯🇵🇨🇳🏴󠁧󠁢󠁥󠁮󠁧󠁿🇨🇦🇲🇽🇻🇳"
//    var emojiChoices = ["Flags":["🏳️‍🌈", "🇺🇸", "🇯🇵","🇨🇳", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇨🇦","🇲🇽", "🇻🇳"],
//                        "Animals":["🐶", "🐒", "🦇", "🐴", "🐬", "🐇", "🐉", "🦍"],
//                        "Faces":["😀","🤓","🤪", "🥺", "🥶", "🤭", "🤮", "👿"]]
    
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func newGame(_ sender: UIButton) {
        game.resetGame()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("choosen card is not in cardButtons")
        }
    }
    
    private func updateViewFromModel(){
        //from model to view, check isFaceUp or not to set the card view
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for:card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCount = game.flipCount
        score = game.score
    }
    
    private var emoji = Dictionary<Card, String>()
    
    private func emoji(for card : Card) -> String{
        if emoji[card] == nil {
            if emojiChoice.count > 0{
                let randomStringIndex = emojiChoice.index(emojiChoice.startIndex, offsetBy: Int.random(in: 0..<emojiChoice.count))
                emoji[card] = String(emojiChoice.remove(at: randomStringIndex))
            }
        }
        return emoji[card] ?? "?"
    }
    
}


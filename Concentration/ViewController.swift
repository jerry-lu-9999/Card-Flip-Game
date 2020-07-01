//
//  ViewController.swift
//  Concentration
//
//  Created by Jiahao Lu on 6/27/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count+1) / 2)
    
    var flipCount:Int = 0{
        didSet{ //property observer
            flipCountLabel.text = "Flip:\(flipCount)"
        }
    }
    
    var score:Int = 0{
        didSet{
            scoreLabel.text = "Score:\(score)"
        }
    }
    
    var emojiChoice = ["🏳️‍🌈", "🇺🇸", "🇯🇵","🇨🇳", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇨🇦","🇲🇽", "🇻🇳"]
    var emojiChoices = ["Flags":["🏳️‍🌈", "🇺🇸", "🇯🇵","🇨🇳", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇨🇦","🇲🇽", "🇻🇳"],
                        "Animals":["🐶", "🐒", "🦇", "🐴", "🐬", "🐇", "🐉", "🦍"],
                        "Faces":["😀","🤓","🤪", "🥺", "🥶", "🤭", "🤮", "👿"]]
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func newGame(_ sender: UIButton) {
        game.resetGame()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("choosen card is not in cardButtons")
        }
    }
    
    func updateViewFromModel(){
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
    
    var emoji = Dictionary<Int, String>()
    
    func emoji(for card : Card) -> String{
        if emoji[card.identifier] == nil {
            if emojiChoice.count > 0{
                let randomIndex = Int.random(in: 0..<emojiChoice.count)
                emoji[card.identifier] = emojiChoice.remove(at: randomIndex)
            }
        }
        return emoji[card.identifier] ?? "?"
    }
}


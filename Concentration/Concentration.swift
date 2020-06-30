//
//  Concentration.swift
//  Concentration
//
//  Created by Jiahao Lu on 6/28/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import Foundation

class Concentration{
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index : Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                //flip every card to face down
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true;
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func resetGame(){
        for flipDownIndex in cards.indices{
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
        }
    }
}

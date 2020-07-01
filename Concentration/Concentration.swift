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
    
    var flipCount = 0
    var score = 0
    var seenCard = Set<Int>()
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index : Int){
//        1. All cards face down, the chosen one gets faced up
//        2. One card is already facing up, the chosen one needs to check if it matches or not
//        3. Two cards facing up, the new chosen one gets faced up, flip the previous two down
        flipCount+=1
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    if seenCard.contains(indexOfOneAndOnlyFaceUpCard!){
                        seenCard.remove(indexOfOneAndOnlyFaceUpCard!)
                    }
                    if seenCard.contains(index){
                        seenCard.remove(index)
                    }
                }else{
                    if seenCard.contains(index){
                        score -= 1
                    }
                    seenCard.insert(index)
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                //either no cards or 2 cards are face up
                //flip every card to face down
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true;
                indexOfOneAndOnlyFaceUpCard = index
                seenCard.insert(indexOfOneAndOnlyFaceUpCard!)
            }
        }
    }
    
    func resetGame(){
        flipCount = 0
        score = 0
        for flipDownIndex in cards.indices{
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
        }
    }
}

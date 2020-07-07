//
//  Concentration.swift
//  Concentration
//
//  Created by Jiahao Lu on 6/28/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import Foundation

struct Concentration{
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var flipCount = 0
    var score = 0
    var seenCard = Set<Int>()
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)):You must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    mutating func chooseCard(at index : Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)):chosen index not in the cards")
//        1. All cards face down, the chosen one gets faced up
//        2. One card is already facing up, the chosen one needs to check if it matches or not
//        3. Two cards facing up, the new chosen one gets faced up, flip the previous two down
        if !cards[index].isMatched{
            flipCount+=1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex] == cards[index]{
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
            }else{
                //either no cards or 2 cards are face up
                //flip every card to face down
                indexOfOneAndOnlyFaceUpCard = index
                seenCard.insert(indexOfOneAndOnlyFaceUpCard!)
            }
        }
    }
    
    mutating func resetGame(){
        flipCount = 0
        score = 0
        for flipDownIndex in cards.indices{
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
        }
    }
}

extension Collection{
    var oneAndOnly: Element?{
        return count == 1 ? first : nil
    }
}

//
//  Cards.swift
//  Concentration
//
//  Created by Jiahao Lu on 6/28/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import Foundation

struct Card : Hashable{
    
    static func == (lhs: Card, rhs:Card) -> Bool{
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(identifier)
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier : Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory+=1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

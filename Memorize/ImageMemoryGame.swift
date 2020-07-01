//
//  ImageMemoryGame.swift
//  Memorize
//
//  Created by Renan Maganha on 29/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

class ImageMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<UIImage> = createMemoryGame()
        
    private static func createMemoryGame() -> MemoryGame<UIImage> {
        let emojis: Array<UIImage> = [#imageLiteral(resourceName: "luffy"), #imageLiteral(resourceName: "zoro"), #imageLiteral(resourceName: "nami"), #imageLiteral(resourceName: "usopp")]
        return MemoryGame<UIImage>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<UIImage>.Card> {
        return model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<UIImage>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = ImageMemoryGame.createMemoryGame()
    }
}



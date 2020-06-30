//
//  ContentView.swift
//  Memorize
//
//  Created by Renan Maganha on 29/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

struct ImageMemoryGameView: View {
    @ObservedObject var viewModel: ImageMemoryGame
    
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(.purple)
        .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImageMemoryGameView(viewModel: ImageMemoryGame())
    }
}

struct CardView: View {
    var card: MemoryGame<UIImage>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Image(uiImage: card.content)
                    .resizable()
                    .aspectRatio(1/1, contentMode: .fit)
                    
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.purple)
            }
        }
        .frame(width: imageSize(for: size.width), height: imageSize(for: size.height))
    }
    
    //MARK: - Drawing Constants
    
    let cornerRadius: CGFloat       = 10.0
    let edgeLineWidth: CGFloat      = 3
    let imageScaleFactor: CGFloat   = 0.75
    
    func imageSize(for size: CGFloat) -> CGFloat {
        size * imageScaleFactor
    }
}

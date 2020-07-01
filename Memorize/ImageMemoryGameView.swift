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
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.5)) {
                        self.viewModel.choose(card: card)
                    }
                }
            }
            .padding()
            .foregroundColor(.purple)
            .font(.largeTitle)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)){
                    self.viewModel.resetGame()
                }
            }) {
                Text("New Game")
            }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<UIImage>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack(alignment: .bottom) {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear{
                                self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(10).opacity(0.4)
                .transition(.identity)
                Image(uiImage: card.content)
                    .resizable()
                    //.clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(card.isMatched ? 1.1 : 1)
                    .animation(card.isMatched ? Animation.linear(duration: 0.5).repeatForever(autoreverses: true) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .frame(width: imageSize(for: size.width), height: imageSize(for: size.height))
            .transition(AnyTransition.scale)
            
        }
    }
    
    //MARK: - Drawing Constants
    
    private let imageScaleFactor: CGFloat   = 0.95
    
    private func imageSize(for size: CGFloat) -> CGFloat {
        size * imageScaleFactor
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = ImageMemoryGame()
        game.choose(card: game.cards[0])
        return ImageMemoryGameView(viewModel: game)
    }
}

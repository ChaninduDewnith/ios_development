//
//  LightItUpGameView.swift
//  ios_development
//
//  Created by student2 on 2026-06-17.
//

import SwiftUI
import Combine

struct LightItUpGameView: View {

    
    @State private var score = 0
    @State private var timeLeft = 60
    @State private var gameOver = false
    @State private var isPlaying = false

    @State private var cards: [Card] = []
    @State private var buttonColor: Color = .blue

    @AppStorage("best_score")
    private var bestScore = 0

    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let colorTimer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()
    
    var currentLevel: Level{
        let elapsed = 60 - timeLeft
        
        switch elapsed {
           case 0..<15:
            return Level(cardCount:3,columns: 3,litWindow: 1.5,litCards: 1)
            
          case 15..<30:
           return Level(cardCount:4,columns: 2,litWindow: 1.2,litCards: 1)
            
          case 30..<45:
           return Level(cardCount:6,columns: 3,litWindow: 1.0,litCards: 1)
            
          default:
            return Level(cardCount:9,columns: 3,litWindow: 0.8,litCards: 2)
        }
    }

   

    var body: some View {

          if gameOver {
              LightItUpGameOverView(score: score, bestScore: bestScore, playAgain: resetGame)
          } else {

              ZStack {
                  Color(red: 0.95, green: 0.97, blue: 1.0)
                      .ignoresSafeArea()

                  VStack(spacing: 0) {

                      
                      HStack(spacing: 12) {

                          
                          HStack(spacing: 6) {
                              Text("Score")
                                  .font(.system(size: 13, weight: .medium, design: .rounded))
                                  .foregroundColor(Color(red: 0.40, green: 0.62, blue: 0.95))
                                  .padding(.horizontal, 10)
                                  .padding(.vertical, 8)
                              Text("\(score)")
                                  .font(.system(size: 16, weight: .semibold, design: .rounded))
                                  .foregroundColor(Color(red: 0.15, green: 0.20, blue: 0.35))
                          }
                          .padding(.horizontal, 14)
                          .padding(.vertical, 10)
                          .background(Color.white)
                          .cornerRadius(12)
                          .overlay(
                              RoundedRectangle(cornerRadius: 12)
                                  .stroke(Color(red: 0.88, green: 0.91, blue: 0.97), lineWidth: 1)
                          )

                          Spacer()

                          
                          Text(levelName)
                              .font(.system(size: 13, weight: .medium, design: .rounded))
                              .foregroundColor(Color(red: 0.40, green: 0.62, blue: 0.95))
                              .padding(.horizontal, 12)
                              .padding(.vertical, 8)
                              .background(Color(red: 0.40, green: 0.62, blue: 0.95).opacity(0.12))
                              .cornerRadius(10)

                          Spacer()

                          
                          HStack(spacing: 6) {
                              
                              Text("Time")
                                  .font(.system(size: 13, weight: .medium, design: .rounded))
                                  .foregroundColor(Color(red: 0.40, green: 0.62, blue: 0.95))
                                  .padding(.horizontal, 10)
                                  .padding(.vertical, 8)
                                
                                  
                              
                              Text("\(timeLeft)s")
                                  .font(.system(size: 16, weight: .semibold, design: .rounded))
                                  .foregroundColor(timeLeft <= 10
                                      ? Color(red: 0.88, green: 0.35, blue: 0.35)
                                      : Color(red: 0.15, green: 0.20, blue: 0.35))
                          }
                          .padding(.horizontal, 14)
                          .padding(.vertical, 10)
                          .background(Color.white)
                          .cornerRadius(12)
                          .overlay(
                              RoundedRectangle(cornerRadius: 12)
                                  .stroke(timeLeft <= 10
                                      ? Color(red: 0.88, green: 0.35, blue: 0.35).opacity(0.4)
                                      : Color(red: 0.88, green: 0.91, blue: 0.97),
                                      lineWidth: 1)
                          )
                      }
                      .padding(.horizontal, 20)
                      .padding(.top, 16)
                      .padding(.bottom, 20)

                      
                      let columns = Array(
                          repeating: GridItem(.flexible(), spacing: 12),
                          count: currentLevel.columns
                      )

                      LazyVGrid(columns: columns, spacing: 12) {
                          ForEach(cards) { card in
                              RoundedRectangle(cornerRadius: 18)
                                  .fill(card.isLit
                                      ? buttonColor.opacity(0.85)
                                      : Color.white)
                                  .frame(height: 95)
                                  .overlay(
                                      RoundedRectangle(cornerRadius: 18)
                                          .stroke(
                                              card.isLit
                                                  ? buttonColor
                                                  : Color(red: 0.88, green: 0.91, blue: 0.97),
                                              lineWidth: card.isLit ? 0 : 1
                                          )
                                  )
                                  .overlay(
                                      
                                      Circle()
                                          .fill(Color.white.opacity(card.isLit ? 0.35 : 0))
                                          .frame(width: 18, height: 18)
                                  )
                                  .scaleEffect(card.isLit ? 1.06 : 1.0)
                                  .shadow(
                                      color: card.isLit
                                          ? buttonColor.opacity(0.30)
                                          : Color.black.opacity(0.04),
                                      radius: card.isLit ? 10 : 4,
                                      x: 0, y: card.isLit ? 4 : 2
                                  )
                                  .animation(.spring(response: 0.3, dampingFraction: 0.65), value: card.isLit)
                                  .onTapGesture {
                                      handleTap(card)
                                  }
                          }
                      }
                      .padding(.horizontal, 20)

                      Spacer()

                      
                      if !isPlaying {
                          Text("Tap the glowing tiles to score")
                              .font(.system(size: 14, weight: .regular, design: .rounded))
                              .foregroundColor(Color(red: 0.55, green: 0.60, blue: 0.70))
                              .padding(.bottom, 32)
                              .transition(.opacity)
                      }
                  }
              }
              .navigationBarHidden(true)
              
              .onReceive(colorTimer) { _ in changeColor() }
              .onReceive(timer) { _ in tick() }
              .onReceive(colorTimer) { _ in changeColor() }
              .onAppear { setupCards() }
          }
      }

      
      var levelName: String {
          let elapsed = 60 - timeLeft
          switch elapsed {
          case 0..<15: return "Level 1"
          case 15..<30: return "Level 2"
          case 30..<45: return "Level 3"
          default: return "Level 4"
          }
      }

      
      func setupCards() {
          cards = (0..<currentLevel.cardCount).map { _ in Card(isLit: false) }
      }

      

      func lightRandomCards() {
          let indices = cards.indices.shuffled()
          for i in indices.prefix(currentLevel.litCards) {
              cards[i].isLit = true
          }
      }

      func updateCards() {
          if cards.count != currentLevel.cardCount {
              cards = (0..<currentLevel.cardCount).map { _ in Card() }
          }
      }

      func handleTap(_ card: Card) {
          guard let index = cards.firstIndex(where: { $0.id == card.id }) else { return }
          withAnimation(.spring()) {
              if cards[index].isLit {
                  score += 1
                  cards[index].isLit = false
              } else {
                  score -= 1
              }
              if !isPlaying { isPlaying = true }
          }
      }
    
    
    func changeColor() {
            let colors: [Color] = [.blue, .green, .orange, .purple]
            buttonColor = colors.randomElement()!
    }
    
    func tick() {
            guard timeLeft > 0 else { endGame(); return }
            if !isPlaying { return }
            timeLeft -= 1
            updateCards()
            lightRandomCards()
    }
    
    
    func endGame() {
            if score > bestScore { bestScore = score }
            gameOver = true
    }

    
    
    func resetGame() {
            score = 0
            timeLeft = 60
            isPlaying = false
            gameOver = false
            buttonColor = .blue
            setupCards()
    }


       
    
    
    
    

    
   

    
    
    
    

    
   

 

    
}

#Preview {
    LightItUpGameView()
}

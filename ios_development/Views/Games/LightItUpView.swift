//
//  LightItUpView.swift
//  ios_development
//
//  Created by cobsccomp251p-055 on 2026-07-09.
//

import SwiftUI
import Combine

struct LightItUpView: View {

    @StateObject private var vm = LightItUpVM()
   
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let colorTimer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()
    
    
    
var body: some View {
    

    if vm.gameOver {
        GameResultView(
              gameName: "Light It Up",
              score: vm.score,
              
        )

          } else {

              ZStack {
                  Color(red: 0.95, green: 0.97, blue: 1.0)
                      .ignoresSafeArea()
                  
                  VStack(spacing: 0) {
                      
                      HStack(spacing: 12) {
                          NavigationLink{
                              HomeView()
                          }label:{
                              Image(systemName: "chevron.left")
                          }
                          Spacer()
                      }
                      .padding()

                      
                      HStack(spacing: 12) {

                          
                          HStack(spacing: 6) {
                              Text("Score")
                                  .font(.system(size: 13, weight: .medium, design: .rounded))
                                  .foregroundColor(Color(red: 0.40, green: 0.62, blue: 0.95))
                                  .padding(.horizontal, 10)
                                  .padding(.vertical, 8)
                              Text("\(vm.score)")
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

                          
                          Text(vm.levelName)
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
                                
                                  
                              
                              Text("\(vm.timeLeft)s")
                                  .font(.system(size: 16, weight: .semibold, design: .rounded))
                                  .foregroundColor(vm.timeLeft <= 10
                                      ? Color(red: 0.88, green: 0.35, blue: 0.35)
                                      : Color(red: 0.15, green: 0.20, blue: 0.35))
                          }
                          .padding(.horizontal, 14)
                          .padding(.vertical, 10)
                          .background(Color.white)
                          .cornerRadius(12)
                          .overlay(
                              RoundedRectangle(cornerRadius: 12)
                                .stroke(vm.timeLeft <= 10
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
                          count: vm.currentLevel.columns
                      )

                      LazyVGrid(columns: columns, spacing: 12) {
                          ForEach(vm.cards) { card in
                              RoundedRectangle(cornerRadius: 18)
                                  .fill(card.isLit
                                        ? vm.levelColor.opacity(0.85)
                                      : Color.white)
                                  .frame(height: 95)
                                  .overlay(
                                      RoundedRectangle(cornerRadius: 18)
                                          .stroke(
                                              card.isLit
                                              ? vm.levelColor
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
                                      ? vm.levelColor.opacity(0.30)
                                          : Color.black.opacity(0.04),
                                      radius: card.isLit ? 10 : 4,
                                      x: 0, y: card.isLit ? 4 : 2
                                  )
                                  .animation(.spring(response: 0.3, dampingFraction: 0.65), value: card.isLit)
                                  .onTapGesture {
                                      vm.handleTap(card)
                                  }
                          }
                      }
                      .padding(.horizontal, 20)

                      Spacer()

                      
                      if !vm.isPlaying {
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.2)) {
                                vm.isPlaying = true
                            }
                        }) {
                            HStack(spacing: 8) {
                                Text("Start Game")
                                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(red: 0.40, green: 0.62, blue: 0.95))
                            )
                            .padding(.horizontal, 28)
                        }
                        .padding(.bottom, 40)
                        .transition(.opacity)
                    }
                  }
              }
              .navigationBarHidden(true)
              .onReceive(timer) { _ in vm.tick() }
              
              .onAppear{
                  vm.setupCards()
                  vm.lightRandomCards()
                  }
              
              
              if vm.showLevelUp {
                VStack(spacing: 12) {
                      Text("LEVEL UP!")
                          .font(.system(size: 38, weight: .bold))
                    Text("Level \(vm.displayedLevel)")
                          .font(.title2)
                          
                  }
                  .padding(40)
                  .background(
                      RoundedRectangle(cornerRadius: 24)
                        .fill(vm.levelColor)
                  )
                  .shadow(color: vm.levelColor.opacity(0.7), radius: 20)
                  .scaleEffect(vm.showLevelUp ? 1 : 0.6)
                  
              }
          }
      }

     

    
    

    
   
    
    
    
    


       
    
    
    
    

    
   

    
    
    
    

    
   

 

    
}



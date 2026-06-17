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

  

    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let colorTimer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()

   

    var body: some View {
        VStack(spacing: 15) {
                   HStack {

                    Text("Score: \(score)")
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .cornerRadius(10)
                        .foregroundColor(.white)

                    Spacer()

                    Text("time\(timeLeft)")
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .padding()

                .padding()

                Spacer()
            }
          
        
    }

    
    
    
    

    
   

    
    
    
    

    
   

 

    
}

#Preview {
    LightItUpGameView()
}

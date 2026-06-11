import SwiftUI
import Combine



struct ContentView: View {
    
    @State private var score = 0
    @State private var timeLeft = 10
    @State private var buttonColor: Color = .blue
    
    @State private var isPlaying = false
    @State private var gameOver = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let colorTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    var body: some View {
        
        if gameOver {
            GameOverView(
                score: score,
                playAgain: resetGame
            )
        } else {
            
            VStack(spacing: 40) {
                
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .bold()
                
                Text("Time: \(timeLeft)")
                    .font(.title)
                
                Button(action: {
                    
                    if !isPlaying{
                        isPlaying = true
                    }
                    
                    
                    else {
                        score += 1
                    }
                    
                }) {
                    Text("TAP ME!")
                        .font(.largeTitle)
                        .frame(width: 200, height: 200)
                        .background(buttonColor)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .scaleEffect(buttonScale())
                        .animation(.easeInOut(duration: 0.3), value: timeLeft)
                }
            }
            .onReceive(timer) { _ in
                
                if isPlaying && timeLeft > 0 {
                    timeLeft -= 1
                }
                
                if timeLeft == 0 && isPlaying {
                    isPlaying = false
                    gameOver = true
                }
            }
            .onReceive(colorTimer) { _ in
                changeColor()
            }
            
            .padding()
        }
    }
    
    func buttonScale() -> CGFloat {
            let maxScale: CGFloat = 1.2
            let minScale: CGFloat = 0.3

            let progress = Double(timeLeft) / 10.0

            return minScale + (maxScale - minScale) * progress
    }
    
    
    func changeColor() {
            let colors: [Color] = [.blue, .green, .gray]
            buttonColor = colors.randomElement()!
    }
    
    
    func resetGame() {
            score = 0
            timeLeft = 10
            isPlaying = false
            gameOver = false
            buttonColor = .blue
    }
    
    
}
   


#Preview {
    ContentView()
}

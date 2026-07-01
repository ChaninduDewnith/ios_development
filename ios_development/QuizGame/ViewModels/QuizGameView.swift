import SwiftUI
import Combine

struct QuizGameView: View {
    @StateObject private var vm = QuizView()

    
    @State private var timeRemaining = 30
    @State private var gameOver = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color(red: 0.23, green: 0.24, blue: 0.27)
                .ignoresSafeArea()

            Group {
                switch vm.state {

                case .loading:
                    ProgressView("Loading...")
                        .tint(.white)
                        .foregroundColor(.white)

                case .failed:
                    VStack(spacing: 16) {
                        Image(systemName: "wifi.exclamationmark")
                            .font(.system(size: 40))
                            .foregroundColor(.white.opacity(0.7))

                        Text("Failed to load questions")
                            .font(.headline)
                            .foregroundColor(.white)

                        Button {
                            Task {
                                await vm.load()
                            }
                        } label: {
                            Text("Retry")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 28)
                                .padding(.vertical, 12)
                                .background(Color(red: 0.23, green: 0.20, blue: 0.54))
                                .cornerRadius(14)
                        }
                    }

                case .loaded:
                    if gameOver {
                        ResultView(score: vm.score){
                            restartGame()
                        }
                       
                    } else if vm.isFinished {
                        ResultView(score: vm.score){
                            restartGame()
                        }
                        
                    } else {
                        quizContent
                    }
                }
            }
        }
        .task {
            await vm.load()
        }
    }

    var quizContent: some View {
        let question = vm.currentQuestion

        return VStack(spacing: 24) {

            VStack(spacing: 10) {

                HStack {

                    Text("Question \(vm.index + 1) of 10")
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.white.opacity(0.75))

                    Spacer()

                    
                    HStack(spacing: 5) {
                        Image(systemName: "clock.fill")
                        Text("\(timeRemaining)s")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.red.opacity(0.8))
                    .clipShape(Capsule())

                    HStack(spacing: 4) {
                        Text("Streak")
                        Text("\(vm.streak)")
                            .fontWeight(.bold)
                    }
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.12))
                    .clipShape(Capsule())
                }

                ProgressView(value: Double(vm.index + 1), total: 10)
                    .tint(Color(red: 0.94, green: 0.60, blue: 0.48))
                    .background(Color.white.opacity(0.15))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)

            
            VStack {
                Text(question.question)
                    .font(.title3.weight(.semibold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.23, green: 0.20, blue: 0.54))
                    .padding(24)
                    .frame(maxWidth: .infinity)
            }
            .background(Color(red: 0.91, green: 0.90, blue: 0.98))
            .cornerRadius(20)
            .padding(.horizontal, 20)

            
            VStack(spacing: 12) {
                ForEach(question.allAnswers, id: \.self) { answer in
                    Button {

                        withAnimation(.easeInOut(duration: 0.2)) {
                            vm.answerTapped(answer)
                        }

                    } label: {

                        HStack {

                            Text(answer)
                                .font(.body.weight(.medium))
                                .multilineTextAlignment(.leading)

                            Spacer()

                            if let selected = vm.selectedAnswer,
                               answer == selected {

                                Image(systemName:
                                        answer == question.correct_answer
                                      ? "checkmark.circle.fill"
                                      : "xmark.circle.fill")
                            }
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(buttonColor(answer))
                        .foregroundColor(.white)
                        .cornerRadius(14)
                    }
                    .disabled(vm.selectedAnswer != nil)
                }
            }
            .padding(.horizontal, 20)

            Spacer()
        }
        .padding(.bottom, 12)

        
        .onReceive(timer) { _ in

            guard !gameOver else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                gameOver = true
            }
        }

      
    }
    
    

    func buttonColor(_ answer: String) -> Color {

        guard let selected = vm.selectedAnswer else {
            return Color(red: 0.23, green: 0.20, blue: 0.54)
        }

        if answer == selected {
            return answer == vm.currentQuestion.correct_answer
            ? Color(red: 0.20, green: 0.60, blue: 0.40)
            : Color(red: 0.75, green: 0.25, blue: 0.25)
        }

        if answer == vm.currentQuestion.correct_answer {
            return Color(red: 0.20, green: 0.60, blue: 0.40)
                .opacity(0.6)
        }

        return Color(red: 0.23, green: 0.20, blue: 0.54)
            .opacity(0.4)
    }
    
    
    
    func restartGame(){
        timeRemaining = 30
        gameOver = false
        
    }
    
   
}

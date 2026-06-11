import SwiftUI




struct ContentView: View {

    @State private var score = 0
    @State private var timeLeft = 10
    @State private var buttonColor: Color = .blue

   
    

    var body: some View {
      VStack(spacing: 30) {
         Text("Score: \(score)")
            .font(.largeTitle)
            bold()
         Text("Time: \(timeLeft)")
            .font(.title)
          Button(action: {
          }) {
            Text("TAP ME!")
            .font(.largeTitle)
            .frame(width: 200, height: 200)
            .background(buttonColor)
            .foregroundColor(.white)
            .clipShape(Circle())
                        
          }
            }
           
            .padding()
        }
    }

    

   


#Preview {
    ContentView()
}

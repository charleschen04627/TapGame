//
//  ContentView.swift
//  TapGame
//
//  Created by Charles on 25/05/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var currentPicIndex = 0
    @State private var difficulty: Difficulty = .easy
    @State private var score: Int = 0
    private let possiblePics = ["apple", "dog", "egg"]
    @State private var targetIndex: Int = 0
    @State private var isRunning: Bool = true
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    
    private enum Difficulty: Double {
        case easy = 1
        case medium = 0.5
        case hard = 0.1
        
        var title: String {
            switch self {
            case .easy:
                return "Easy"
            case .medium:
                return "Medium"
            case .hard:
                return "Hard"
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                if !isRunning {
                    Menu("Difficulty \(difficulty.title)") {
                        Button(Difficulty.easy.title) {
                            difficulty = .easy
                        }
                        Button(Difficulty.medium.title) {
                            difficulty = .medium
                        }
                        Button(Difficulty.hard.title) {
                            difficulty = .hard
                        }
                    }
                }
                Spacer()
                Text("Score: \(score)")
            }
            .padding(.horizontal)
            Image(possiblePics[currentPicIndex])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .onTapGesture {
                    timer.upstream.connect().cancel()
                    checkAnswer()
                }
            Text(possiblePics[targetIndex])
                .font(.system(size: 20, weight: .semibold))
            if !isRunning {
                Button("Restart") {
                    timer = Timer.publish(every: difficulty.rawValue, on: .main, in: .common).autoconnect()
                    isRunning = true
                    showAlert = false
                }
            }
        }
        .onReceive(timer) { _ in
            changePic()
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK"){
                
            }
        } message: {
            Text(alertMessage)
        }

    }
    
    private func checkAnswer() {
        if currentPicIndex == targetIndex {
            score += 1
            targetIndex = Int.random(in: 0..<possiblePics.count)
            alertTitle = "Correct!"
            alertMessage = "You got it right! Keep going!"
        } else {
            alertTitle = "Oops!"
            alertMessage = "You got it wrong! Try again!"
        }
        isRunning = false
        showAlert = true
    }
    
    private func changePic() {
        currentPicIndex = (currentPicIndex + 1) % possiblePics.count
    }
}

#Preview {
    ContentView()
}

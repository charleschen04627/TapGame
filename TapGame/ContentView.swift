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
            Button("Restart") {
                timer = Timer.publish(every: difficulty.rawValue, on: .main, in: .common).autoconnect()
            }
                
        }
        .onReceive(timer) { _ in
            changePic()
        }
    }
    
    private func checkAnswer() {
        if currentPicIndex == targetIndex {
            score += 1
            targetIndex = Int.random(in: 0..<possiblePics.count)
        }
    }
    
    private func changePic() {
        currentPicIndex = (currentPicIndex + 1) % possiblePics.count
    }
}

#Preview {
    ContentView()
}

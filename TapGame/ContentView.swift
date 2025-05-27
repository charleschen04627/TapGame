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
    @State private var animateGradient = false
    
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
        ZStack {
            LinearGradient(
                colors: [Color.blue, Color.green, Color.red],
                startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            .hueRotation(.degrees((animateGradient ? 360 : 0)))
            .onAppear {
                withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                    animateGradient.toggle()
                }
            }
            
            VStack(spacing: 10) {
                Image(systemName: "flag.2.crossed.fill")
                    .symbolEffect(.wiggle.counterClockwise, options: .repeating)
                    .font(.system(size: 40, weight: .bold))
                Text("Reaction")
                    .font(.system(size: 40, weight: .bold))
                HStack {
                    Menu {
                        Button(Difficulty.easy.title) {
                            difficulty = .easy
                        }
                        Button(Difficulty.medium.title) {
                            difficulty = .medium
                        }
                        Button(Difficulty.hard.title) {
                            difficulty = .hard
                        }
                    } label: {
                        Label(("Difficulty \(difficulty.title)"), systemImage: "arrowtriangle.down.fill")
                            .symbolEffect(.wiggle.wholeSymbol, options: .repeating)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.black)
                    }
                    .opacity(isRunning ? 0 : 1)
                    Spacer()
                    Text("Score: \(score)")
                }
                .padding(.horizontal)
                Image(possiblePics[currentPicIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .background(Color.white)
                    .border(Color.black, width: 5)
                    .onTapGesture {
                        if isRunning {
                            timer.upstream.connect().cancel()
                            checkAnswer()
                        }
                    }
                Text("Tap \(possiblePics[targetIndex]) !")
                    .font(.system(size: 20, weight: .semibold))
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .symbolEffect(.wiggle, options: .repeating)
                    .onTapGesture {
                        timer = Timer.publish(every: difficulty.rawValue, on: .main, in: .common).autoconnect()
                        isRunning = true
                        showAlert = false
                    }
                    .opacity(isRunning ? 0 : 1)
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

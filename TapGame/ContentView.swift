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
    
    private let possiblePics = ["apple", "dog", "egg"]
    
    var body: some View {
        VStack {
            Image(possiblePics[0])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
        }
    }
    
    private func changePic() {
        currentPicIndex = (currentPicIndex + 1) % possiblePics.count
    }
}

#Preview {
    ContentView()
}

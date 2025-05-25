//
//  ContentView.swift
//  TapGame
//
//  Created by Charles on 25/05/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let possiblePics = ["apple", "dog", "egg"]
    
    var body: some View {
        VStack {
            Image(possiblePics[0])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
        }
    }
}

#Preview {
    ContentView()
}

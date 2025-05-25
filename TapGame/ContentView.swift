//
//  ContentView.swift
//  TapGame
//
//  Created by Charles on 25/05/2025.
//

import SwiftUI

struct ContentView: View {
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

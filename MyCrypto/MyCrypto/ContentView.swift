//
//  ContentView.swift
//  MyCrypto
//
//  Created by Vipal on 05/10/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .foregroundColor(Color.theme.accent)
            Text("Hello, world!")
                .foregroundColor(Color.theme.backgroundColor)
            Text("Hello, world!")
                .foregroundColor(Color.theme.greenColor)
            Text("Hello, world!")
                .foregroundColor(Color.theme.redColor)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

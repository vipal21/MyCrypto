//
//  CircleButton.swift
//  MyCrypto
//
//  Created by Vipal on 05/10/22.
//

import SwiftUI

struct CircleButton: View {
    var iconName: String
    var body: some View {
       Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50 , height: 50)
            .background {
                Circle()
                    .foregroundColor(Color.theme.backgroundColor)
            }
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10 , x: 0,y: 0)
            .padding()
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButton(iconName: "heart.fill")
                .previewLayout(.sizeThatFits)
        }
       
    }
}

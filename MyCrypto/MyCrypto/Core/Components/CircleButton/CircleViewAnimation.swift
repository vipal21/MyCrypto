//
//  CircleViewAnimation.swift
//  MyCrypto
//
//  Created by Vipal on 05/10/22.
//

import SwiftUI

struct CircleViewAnimation: View {
    @Binding var animate: Bool
    var body: some View {
        Circle()
            .scale(animate ? 1.0 : 0.0)
            .stroke(lineWidth: 5.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none)

    }
}

struct CircleViewAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CircleViewAnimation(animate: .constant(false))
            .foregroundColor(.red)
            .frame(width: 100,height: 100)
    }
}

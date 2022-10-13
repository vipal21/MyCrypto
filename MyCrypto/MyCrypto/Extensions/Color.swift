//
//  Color.swift
//  MyCrypto
//
//  Created by Vipal on 05/10/22.
//

import Foundation
import SwiftUI
//extensions allow you to add functionality to an existing
//   type (class, struct, enumeration.)
//   We can Add computed properties (including static)
//We are ading new static theme colors to system color class so we crated struct and store the value and in Color we added that color.
 extension  Color {
    static let theme = ColorTheam()
     static let launch = LaunchTheam()
     
}
struct ColorTheam {
    let accent = Color("AccentColor")
    let backgroundColor = Color("BackgroundColor")
    let greenColor = Color("GreenColor")
    let redColor = Color("RedColor")
    let secondaryTextColor = Color("SecondaryTextColor")
}
struct LaunchTheam {
    let accent = Color("LaunchAccentColor")
    let backgroundColor = Color("LaunchBackgroundColor")

}

//
//  UIApplication.swift
//  MyCrypto
//
//  Created by Vipal on 06/10/22.
//

import Foundation
import SwiftUI
extension UIApplication {
    func endEditing (){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

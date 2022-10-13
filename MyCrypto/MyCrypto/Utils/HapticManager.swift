//
//  File.swift
//  MyCrypto
//
//  Created by Vipal on 10/10/22.
//

import Foundation
import SwiftUI

class HapticManager {
    static let generator = UINotificationFeedbackGenerator()
    static func notification (type:UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}

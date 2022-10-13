//
//  StatistcModel.swift
//  MyCrypto
//
//  Created by Vipal on 06/10/22.
//

import Foundation
struct StatistcModel : Identifiable {
    let id = UUID().uuidString
    let title : String
    let value : String
    let percentageChange : Double?
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}


//
//  String.swift
//  MyCrypto
//
//  Created by Vipal on 12/10/22.
//


import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}

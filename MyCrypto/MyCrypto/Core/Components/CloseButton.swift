//
//  CloseButton.swift
//  MyCrypto
//
//  Created by Vipal on 07/10/22.
//

import SwiftUI

struct CloseButton: View {
    
    @Binding var presentationMode : PresentationMode
    var body: some View {
        Button(action: {
            $presentationMode.wrappedValue.dismiss()
       }, label: {
           Image(systemName: "xmark")
               .font(.headline)
       })
    }
}


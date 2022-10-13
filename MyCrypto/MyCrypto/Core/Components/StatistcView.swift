//
//  StatistcView.swift
//  MyCrypto
//
//  Created by Vipal on 06/10/22.
//

import SwiftUI

struct StatistcView: View {
    let  statistc :  StatistcModel
    var body: some View {
        VStack(alignment: .leading ,spacing: 4) {
            Text(statistc.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
            Text(statistc.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack (spacing : 0) {
                Image(systemName: "triangle.fill")
                    .rotationEffect(
                        Angle(degrees: (statistc.percentageChange ?? 0 ) >= 0 ? 0 : 180))
                Text(statistc.percentageChange?.asPercentageString() ?? "")
                    .font(.caption2)
                    .bold()
            }
            .foregroundColor( (statistc.percentageChange ?? 0 ) >= 0 ? Color.theme.greenColor : Color.theme.redColor)
            .opacity(statistc.percentageChange == nil ? 0 : 1)
            
        }
    }
}

struct StatistcView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            StatistcView(statistc: dev.statistc1)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            StatistcView(statistc: dev.statistc2)
                .previewLayout(.sizeThatFits)
            StatistcView(statistc: dev.statistc3)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
   
    }
}

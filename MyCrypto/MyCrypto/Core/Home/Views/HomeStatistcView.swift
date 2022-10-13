//
//  HomeStatistcView.swift
//  MyCrypto
//
//  Created by Vipal on 06/10/22.
//

import SwiftUI

struct HomeStatistcView: View {

    @EnvironmentObject private var vm : HomeViewModel
    @Binding var showProtfolio :Bool
    var body: some View {
        HStack {
            
            ForEach(vm.statistics) { item in
                StatistcView(statistc: item)
                    .frame(width: UIScreen.main.bounds.width/3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showProtfolio ? .trailing : .leading)
    }
}

struct HomeStatistcView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatistcView(showProtfolio: .constant(true))
            .environmentObject(DeveloperPreview.instance.homeVM)
    }
}

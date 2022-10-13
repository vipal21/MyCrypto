//
//  DetailView.swift
//  MyCrypto
//
//  Created by Vipal on 10/10/22.
//

import SwiftUI
import Combine

struct DetailView: View {
    @StateObject private var vm : DetailViewModel
    @State private var showFullDesc : Bool = false
     var coin : CoinModel
    private let columns :[GridItem]  = [
        GridItem(.flexible()),
        GridItem(.flexible())
     ]
    private let spacing: CGFloat = 30
    init(coin : CoinModel) {
        self.coin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    var body: some View {
        ScrollView {
         
            VStack {
                ChartView(coin: vm.coin)
                VStack (spacing:20){
                    overViewTitle
                    Divider()
                    description
                    overViewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    website
                }
            }
            

            .navigationTitle(vm.coin.name)
            .toolbar {
                navigationBarTrailingView
            }
        }
        .background(
            Color.theme.backgroundColor
            .ignoresSafeArea()
        )
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
                }
       
    }
}
extension DetailView {
    private var website: some View {
        VStack (alignment:.leading,spacing: 20){
            if let websiteURL = vm.websiteURL,
               let url = URL(string: websiteURL)
            {
                Link("Website Link", destination: url)
            }
            if let redditURL = vm.redditURL,
               let url = URL(string: redditURL){
                Link("Reddit Link", destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity,alignment: .leading)
        .font(.headline)
    }
    private var description: some View {
    ZStack {
        if let coinDescription = vm.coinDescription,
           !coinDescription.isEmpty {
            VStack (alignment :.leading){
                Text(coinDescription)
                    .lineLimit( showFullDesc ? nil : 3)
                    .font(.callout)
                    .foregroundColor(Color.theme.secondaryTextColor)
                Button {
                    withAnimation(.easeOut){
                        showFullDesc.toggle()
                    }
                } label: {
                    Text(showFullDesc ? "Less":"Read More")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.vertical,4)
                    
                }
                .accentColor(.blue)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        }
        
    }
}
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.leading)
    }
    private var additionalGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            
            ForEach(vm.additionalStatistics) { item in
                
                StatistcView(statistc: item)
                    .padding(.leading)
                
            }
        }
    }
    private var overViewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
          
            ForEach(vm.overviweStatistics) { item in
                
                StatistcView(statistc: item)
                    .padding(.leading)
            }
            
        }
    }
    private var overViewTitle: some View {
        Text("OverView")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.leading)
    }

    private var navigationBarTrailingView: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .foregroundColor(Color.theme.secondaryTextColor)
            CoinImageView(coin: vm.coin)
                .frame(width: 25,height: 25)
        }
    }
   
}
struct DetailLoadingView: View {

    @Binding var coin: CoinModel?

    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
    
}

//
//  HomeView.swift
//  MyCrypto
//
//  Created by Vipal on 05/10/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @State private var showPortFolio:Bool = false
    @State private var showPortFolioView:Bool = false
    @State private var showSettingsView: Bool = false // new sheet
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView:Bool = false
    var body: some View {
        ZStack {
            // background
            Color.theme.backgroundColor
                .ignoresSafeArea()
                .sheet(isPresented: $showPortFolioView, content: {
                                    PortFolioView()
                                        .environmentObject(vm)
                                })
            //content
            VStack {
                headerView
                HomeStatistcView(showProtfolio:$showPortFolio)
                SearchBarView(txtSearch: $vm.searchText)
                columnTitles
             
                if !showPortFolio {
                    allCoinList
                }
                if showPortFolio {
                    ZStack (alignment: .top) {
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty{
                            portfolioEmptyText
                        }else{
                            allPortFolioCoinList
                        }
                    }.transition(.move(edge: .trailing))
                   
                }
              
                Spacer()
            }
            .sheet(isPresented: $showSettingsView, content: {
                           SettingsView()
                       })
        }
        .background(
                    NavigationLink(
                        destination: DetailLoadingView(coin: $selectedCoin),
                        isActive: .constant(showDetailView),
                        label: { EmptyView() })
                )

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }.environmentObject(DeveloperPreview.instance.homeVM)
    }
}
extension HomeView {
    private var portfolioEmptyText: some View {
        Text("You haven't added any coins to your portfolio yet. Click the + button to get started! 🧐")
            .font(.callout)
            .foregroundColor(Color.theme.accent)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(50)
    }
    private func segue1(coin : CoinModel){
        selectedCoin = coin
        showDetailView.toggle()
    }
    private var columnTitles : some View {
        HStack {
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
              //  vm.sortOption = vm.sortOption = .rank ? .rankReversed : .rankReversed
                if(vm.sortOption == .rank){
                    vm.sortOption = .rankReversed
                }else{
                    vm.sortOption = .rank
                }
            }
          
            Spacer()
            if showPortFolio {
               
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1 : 0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    if(vm.sortOption == .holdings){
                        vm.sortOption = .holdingsReversed
                    }else{
                        vm.sortOption = .holdings
                    }
                }
            }
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                if(vm.sortOption == .price){
                    vm.sortOption = .priceReversed
                }else{
                    vm.sortOption = .price
                }
            }
          
                .frame(width: UIScreen.main.bounds.width/3.5 ,alignment: .trailing)
            Button {
                withAnimation (.linear(duration: 2.0)){
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }.rotationEffect(Angle(degrees: vm.isLoading  ? 380 : 0 ),anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryTextColor)
        .padding(.horizontal)
    }
    
    private var allPortFolioCoinList : some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColum: true )
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .animation(.none)
                    .listRowBackground(Color.theme.backgroundColor)
            }

        }
        .listStyle(.plain)
        
    }
    private var allCoinList : some View {
        List {
            ForEach(vm.allCoins) { coin in
                
                CoinRowView(coin: coin, showHoldingColum: false )
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .listRowBackground(Color.theme.backgroundColor)
                    .onTapGesture {
                        segue1(coin: coin)
                    }
            }

        }
        .listStyle(.plain)
        .transition(.move(edge: .leading))
    }
    private var allCoinList1: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColum: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue1(coin: coin)
                    }
                    .listRowBackground(Color.theme.redColor)
            }
        }
        .listStyle(PlainListStyle())
    }
    private func sgeue (coin : CoinModel){
        
    }
    private var headerView: some View {
        HStack {
            CircleButton(iconName: showPortFolio ? "info" : "plus" )
                .animation(.none)
                .background {
                    CircleViewAnimation(animate: $showPortFolio)
                }
                .onTapGesture {
                    if showPortFolio {
                        showPortFolioView = true
                    }else {
                        showSettingsView.toggle()
                    }
                }
            Spacer()
            Text( showPortFolio ? "Portfolio" : "Live Price")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButton(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortFolio ? 180 : 0))
                .onTapGesture {
                    withAnimation (.spring()){
                        showPortFolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}

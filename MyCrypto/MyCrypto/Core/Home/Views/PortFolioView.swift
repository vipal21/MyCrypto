//
//  PortFolioView.swift
//  MyCrypto
//
//  Created by Vipal on 07/10/22.
//

import SwiftUI

struct PortFolioView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var vm: HomeViewModel
 
    @State  private var selectedCoin : CoinModel? = nil
    @State  private var txtAmount : String = ""
    @State  private var showCheckMark : Bool = false
    var body: some View {
        NavigationView {
            ScrollView{
                
                VStack(alignment:.leading,spacing: 10){
                    SearchBarView(txtSearch: $vm.searchText)
                    ScrollView(.horizontal,showsIndicators: false){
                        coinLogoList
                
                    }
                    if  self.selectedCoin != nil {
                       
                        portfolioInputSection
                    }
                }
            }.background( Color.theme.backgroundColor)
            .navigationTitle("Edit Portfolio")
//            .navigationBarItems(leading:CloseButton(presentationMode: presentationMode))
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    CloseButton(presentationMode: presentationMode)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavigationButton
                }
            })
            .onChange(of: vm.searchText) { value in
                if value == "" {
                    removeSelectedCoin()
                }
            }
        }
    }

}

struct PortFolioView_Previews: PreviewProvider {

    static var previews: some View {
        PortFolioView()
            .environmentObject(dev.homeVM)
    }
}
extension PortFolioView{
    private var trailingNavigationButton : some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1:0)
            Button {
            
                saveButtonPress()
            } label: {
                Text("Save".uppercased())
            }.opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(txtAmount) ? 1:0)

           
        }
        .font(.headline)
    }
    private var portfolioInputSection : some View{
        VStack(spacing: 20){
            HStack {
                Text("Current price of : \(selectedCoin?.symbol.uppercased() ?? "" )")
                Spacer()
                Text((selectedCoin?.currentPrice.asCurrencyWith6decimals() ?? "" ))
            }
            Divider()
            HStack {
                Text("Amount holding : ")
                Spacer()
                TextField("EX : 1.4", text: $txtAmount)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Curret value : ")
                Spacer()
                Text(getCurrencyValueDouble().asCurrencyWith2decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    private var coinLogoList: some View {
        
        LazyHStack(spacing :10) {
            ForEach(vm.searchText.isEmpty ? vm.portfolioCoins :  vm.allCoins) { coin in
                CoinLogoView(coin: coin)
                    .frame(width: 75)
                    .padding(4)
                    .onTapGesture(perform: {
    
                        updateSelectedCoine(coin: coin)
                    })
                    .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedCoin?.id == coin.id ? Color.theme.greenColor : Color.clear,lineWidth: 1))
                
            }
        }
        .padding(.vertical , 4)
        .padding(.leading)
    }
    private func updateSelectedCoine(coin:CoinModel){
        selectedCoin = coin
            if let portfoliocoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
            let amount =   portfoliocoin.currentHoldings{
                txtAmount = "\(amount)"
            }else{
                txtAmount = ""
            }
        
    }
    func getCurrencyValueDouble() -> Double {
        if let amount = Double(txtAmount){
            return amount * (selectedCoin?.currentPrice ?? 0)
            
        }
        return 0
    }

    private func saveButtonPress() {
        
        guard
            let coin = selectedCoin,
            let amount = Double(txtAmount)
            else { return }
        
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
        
    }
    private  func removeSelectedCoin () {
        selectedCoin = nil
        txtAmount = ""
        // hide key board
        UIApplication.shared.endEditing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            withAnimation {
                showCheckMark = false
            }
        }
    }
}

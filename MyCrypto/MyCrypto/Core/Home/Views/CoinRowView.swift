//
//  CoinRowView.swift
//  MyCrypto
//
//  Created by Vipal on 05/10/22.
//

import SwiftUI

struct CoinRowView: View {
    let coin :CoinModel
    let showHoldingColum : Bool
    var body: some View {
        HStack (spacing: 0){
            leftColumn
            Spacer()
            if showHoldingColum{
                centerColumn
            }
            righrColumn
        }
        .font(.subheadline)
        .background(Color.theme.backgroundColor.opacity(0.001))
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingColum: true)
                .previewLayout(.sizeThatFits)
            CoinRowView(coin: dev.coin, showHoldingColum: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}
extension CoinRowView{
    private var leftColumn : some View {
        HStack (spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30,height: 30)
                .padding(.trailing)
            Text(coin.symbol.uppercased())
        }
        
    }
    private var centerColumn : some View {
        VStack (alignment : .trailing) {
            Text(coin.currentHoldingValue.asCurrencyWith2decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())

        }
        .foregroundColor(Color.theme.accent)
    }
    private var righrColumn : some View {
        VStack (alignment : .trailing) {
            Text(coin.currentPrice.asCurrencyWith6decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentageString() ?? "")
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ?
                                 Color.theme.greenColor :
                                    Color.theme.redColor )
        }
        .frame(width: UIScreen.main.bounds.width/3.5 ,alignment: .trailing)
    }
    
}

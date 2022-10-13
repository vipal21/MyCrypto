//
//  CoinDetailService.swift
//  MyCrypto
//
//  Created by Vipal on 11/10/22.
//


import Foundation
import Combine
class CoinDetailService {
    @Published var coinDetail:CoinDetailModel? = nil
    var coinDetailSubscription : AnyCancellable?
    var coin: CoinModel
    init(coin: CoinModel) {
        self.coin = coin
        getData(coin: coin)
    }
     func getData(coin: CoinModel){
         let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
         coinDetailSubscription =  NetworkManager.download(url: url!)

            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)

        //6. useitems
            .sink(receiveCompletion: NetworkManager.receiveCompletion, receiveValue: {[weak self] returnedcoinDetail in
                self?.coinDetail = returnedcoinDetail
                self?.coinDetailSubscription?.cancel()
            })
   
    
    }
}

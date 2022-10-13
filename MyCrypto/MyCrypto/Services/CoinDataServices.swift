//
//  CoinDataServices.swift
//  MyCrypto
//
//  Created by Vipal on 06/10/22.
//

import Foundation
import Combine
class CoinDataServices {
    @Published var allCoins:[CoinModel] = []
    var coinSubscription : AnyCancellable?
    init() {
        getData()
    }
     func getData(){
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        //Setps for url session with publisher
        //1. create publisher with data task
        //2. subscribe that publisher and put on background thread
        //3. recive data on main thread
        //4. try map and check data good or not (return Data or thows Error)
        //5. decodedata
        //6. useitems
        //7. cancle subscription
        
        //1. create publisher with data task
        coinSubscription =  NetworkManager.download(url: url!)
//        //2. subscribe that publisher and put on background thread
//            .subscribe(on: DispatchQueue.global(qos: .default))
//        //3. recive data on main thread
//            .receive(on: DispatchQueue.main)
//        //4. try map and check data good or not
//            .tryMap { (output) -> Data  in
//                guard let response = output.response as? HTTPURLResponse,
//                      response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(.badServerResponse)
//                }
//                return output.data
//
//            }
        //5. decodedata
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)

        //6. useitems
            .sink(receiveCompletion: NetworkManager.receiveCompletion, receiveValue: {[weak self] coindata in
                self?.allCoins = coindata
                self?.coinSubscription?.cancel()
            })
   
    
    }
}

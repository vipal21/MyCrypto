//
//  MarketDataService.swift
//  MyCrypto
//
//  Created by Vipal on 07/10/22.
//

import Foundation
import Combine
class MarketDataService {
    @Published var matketData:MarketDataModel? = nil
    var matketDataSubscription : AnyCancellable?
    init() {
        getData()
    }
     func getData(){
        let url = URL(string: "https://api.coingecko.com/api/v3/global")
            matketDataSubscription =  NetworkManager.download(url: url!)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.receiveCompletion, receiveValue: {[weak self] returnedGlobalData in
                self?.matketData = returnedGlobalData.data
                self?.matketDataSubscription?.cancel()
            })
   
    
    }
}

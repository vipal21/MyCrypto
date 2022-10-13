//
//  DetailViewModel.swift
//  MyCrypto
//
//  Created by Vipal on 11/10/22.
//

import Foundation
import Combine

class DetailViewModel:ObservableObject
{
    @Published var overviweStatistics : [StatistcModel] = []
    @Published var additionalStatistics : [StatistcModel] = []
    @Published var websiteURL : String? = nil
    @Published var redditURL : String? = nil
    @Published var coinDescription : String? = nil
    

    private let coinDetailService: CoinDetailService
    private var cancellables = Set<AnyCancellable>()
    @Published var  coin : CoinModel

    
    init(coin: CoinModel) {
        self.coin = coin
        coinDetailService = CoinDetailService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetail
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] (returnedArrays) in
                            self?.overviweStatistics = returnedArrays.overview
                            self?.additionalStatistics = returnedArrays.additional
                        }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetail
            .sink { [weak self] returnedCoinDetail in
                self?.coinDescription = returnedCoinDetail?.readableDescription
                self?.websiteURL = returnedCoinDetail?.links?.homepage?.first
                self?.redditURL = returnedCoinDetail?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatistcModel], additional: [StatistcModel]) {
         let overviewArray = createOverviewArray(coinModel: coinModel)
         let additionalArray = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
         return (overviewArray, additionalArray)
     }
    private func createOverviewArray(coinModel: CoinModel) -> [StatistcModel] {
        let price = coinModel.currentPrice.asCurrencyWith6decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatistcModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatistcModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatistcModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatistcModel(title: "Volume", value: volume)
        
        let overviewArray: [StatistcModel] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        return overviewArray
    }
    
    private func createAdditionalArray(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatistcModel] {
        
        let high = coinModel.high24H?.asCurrencyWith6decimals() ?? "n/a"
        let highStat = StatistcModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6decimals() ?? "n/a"
        let lowStat = StatistcModel(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6decimals() ?? "n/a"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatistcModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatistcModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatistcModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatistcModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [StatistcModel] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
        return additionalArray
    }
    
}

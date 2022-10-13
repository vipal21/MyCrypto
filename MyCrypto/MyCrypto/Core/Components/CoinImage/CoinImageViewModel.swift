//
//  CoinImageViewModel.swift
//  MyCrypto
//
//  Created by Vipal on 06/10/22.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel : ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading : Bool = false
    private let coin : CoinModel
    private let dataServices : CoinImageServices
    var cancellable =  Set<AnyCancellable>()

    
    init (coin : CoinModel) {
        self.coin = coin
        dataServices = CoinImageServices(coin:  self.coin )
        getImage()
    }
    private func getImage (){
        addSubscribers()
    }
    private func addSubscribers() {
        isLoading = true
        dataServices.$image.sink {[weak self] _ in
            self?.isLoading = false
        } receiveValue: {[weak self] image in
            guard let image = image else { return }
            self?.isLoading = false
            self?.image = image
        }
        .store(in: &cancellable)

    }
    
    
}

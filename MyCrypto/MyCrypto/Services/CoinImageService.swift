//
//  CoinImageService.swift
//  MyCrypto
//
//  Created by Vipal on 06/10/22.
//

import Foundation
import SwiftUI
import Combine
class CoinImageServices {
    @Published var image: UIImage? = nil
    var imageSubscription : AnyCancellable?
    private let coinFM = CoinFileManager.instance
    private let coin : CoinModel
    private let folderName =  "coin_images"
    private let imageName:String
    
    init (coin : CoinModel) {
        imageName = coin.id
        self.coin = coin
        getCoinImage()
        
    }
    private func getCoinImage (){
        if let savedimage =  coinFM.getImage(imageName: coin.id, folderName: folderName){
            image = savedimage
          //  print("recived form DB")
        }else{
          //  print("Download Image")
            downloadCoinImage(urlString: self.coin.image)
        }
    }
    private func downloadCoinImage (urlString : String)
    {
        let url = URL(string: urlString)
  
        imageSubscription =  NetworkManager.download(url: url!)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.receiveCompletion, receiveValue: {[weak self] returnImage in
                guard let self = self,
                let returnImage = returnImage
                else { return }
                self.image = returnImage
                self.imageSubscription?.cancel()
                self.coinFM.saveImage(image:returnImage , imageName:self.imageName, foldername: self.folderName)
            })
    }
}

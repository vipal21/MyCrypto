//
//  NetworkManager.swift
//  MyCrypto
//
//  Created by Vipal on 06/10/22.
//

import Foundation
import Combine
class NetworkManager {
    enum NetworkingError : LocalizedError {
        case badURLResponse(url:URL)
        case unknown
        var errorSescription: String?{
            switch self
            {
            case.badURLResponse(url: let url) : return "Bad response from URL\(url)"
                case.unknown : return "unknown error occure"
            }
        }
    }
    static func download (url : URL) -> AnyPublisher <Data ,Error>{
        URLSession.shared.dataTaskPublisher(for: url)
           // .subscribe(on: DispatchQueue.global(qos: .default))
            //.receive(on: DispatchQueue.main)
            .tryMap({try handleResponse(output: $0, url: url)})
            .retry(3)
            .eraseToAnyPublisher()
         
    }
    static func handleResponse (output : URLSession.DataTaskPublisher.Output ,url : URL) throws -> Data {
        
        guard let response =  output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else {throw NetworkingError.badURLResponse(url: url)}
         return output.data
        
    }
    static func receiveCompletion (completion : Subscribers.Completion<any Error>){
        switch completion {
        case .finished :
            print("finished")
        case .failure(let error):
            print("fail with error: \(error.localizedDescription)")
        }
    }
    
}

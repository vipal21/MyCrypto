//
//  CoinFileManager.swift
//  MyCrypto
//
//  Created by Vipal on 06/10/22.
//

import Foundation
import SwiftUI
final class CoinFileManager{
    static let instance = CoinFileManager()
    private init(){}
    func saveImage(image:UIImage , imageName:String , foldername:String){
        // create folder if needed
        
        createFolderIfNeeded(folderName: foldername)
        
        //get path for the image
        
       guard let data = image.pngData() ,// if jpeg use jpeg(),
             let url = getUrlForImage(imageName: imageName, foldername: foldername)
        else {return}
        
        //save image to path
        
        do {
            try  data.write(to: url)
            print("Sucessfully write on file")
        } catch let error {
            print("Error in write : \(error.localizedDescription)")
        }
       
    }
    func getImage(imageName : String , folderName : String) -> UIImage?{
        
       guard let url = getUrlForImage(imageName: imageName, foldername: folderName),
             FileManager.default.fileExists(atPath: url.path) else {return nil}
        return UIImage(contentsOfFile:url.path )
             
    }
    private func createFolderIfNeeded(folderName:String) {
        guard let url = getUrlForFolder(foldername: folderName) else { return  }
        if !FileManager.default.fileExists(atPath: url.path){
            do {
                try  FileManager.default.createDirectory(at:url , withIntermediateDirectories: true)
            } catch let error {
                print("Error in Create Folder :\(folderName). \(error.localizedDescription)")
            }
           
        }
    }
    private func getUrlForFolder(foldername:String) -> URL?{
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        return url.appendingPathComponent(foldername)
    }
    private func getUrlForImage(imageName:String , foldername : String) -> URL?{
        guard let folderUrl = getUrlForFolder(foldername: foldername) else {return nil}
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
}

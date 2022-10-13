//
//  PortfolioDataService.swift
//  MyCrypto
//
//  Created by Vipal on 10/10/22.
//

import Foundation
import CoreData

//continer
//Load DB
//Get Table using fetch request and with viewcontext
//add values to table using view context
//save data in continer using save continer.viewcontext
class PortfolioDataService{
    @Published var savedEntities : [PortfolioEntity] = []
    //1. Create persisrtance
    private let continer : NSPersistentContainer
    init (){
        continer =  NSPersistentContainer(name: "PortfolioContiner")
        continer.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading coredata\(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    // Punlic
    
    func updatePortfolio (coin : CoinModel , amount :Double){
        //check the coin is in portfolio
        if let enitiy = savedEntities.first(where: {$0.coinID == coin.id}){
            if amount > 0 {
                update(enitity: enitiy, amount: amount)
            }else
            {
                remove(entity: enitiy)
            }
        }
        else
        {
            add(coin: coin, amount: amount)
        }
       
    }
    //Private functions
    //2. get table
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: "PortfolioEntity")
        do {
            savedEntities =   try continer.viewContext.fetch(request)
        } catch (let error) {
            print("Error fetching portfolio Enitity \(error.localizedDescription)")
        }
        
    }
    private func add(coin :CoinModel ,amount : Double){
        let entity = PortfolioEntity(context: continer.viewContext) // get item with context and add value to the properties
        entity.coinID = coin.id
        entity.amout = amount
        applychanges()
    }
    private func update (enitity : PortfolioEntity ,amount : Double){
         enitity.amout = amount
        applychanges()
    }
    private func remove(entity :PortfolioEntity){
        continer.viewContext.delete(entity)
        applychanges()
    }
    private func save(){
        do {
            try continer.viewContext.save()
        } catch (let error) {
            print("Error saving \(error.localizedDescription)")
        }
    }
    private func applychanges (){
        save()
        getPortfolio()
    }
}

//
//  RestaurantDetailsPresenter.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/25/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
protocol RestaurantDetailsPresenterProtocol {
    func addToCart(restID:Int,price:Double,count:Int,name:String,amount:Int)
}
class RestaurantDetailsPresenter : RestaurantDetailsPresenterProtocol {
    
    
    var interactor: RestaurantDetailsIteractorProtocol
    var router: RestaurantDetailsRouterProtocol
    
    init(interactor: RestaurantDetailsIteractorProtocol,router: RestaurantDetailsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    func addToCart(restID:Int,price:Double,count:Int,name:String,amount:Int){
        interactor.addToCart(restID: restID,price: price,count:count,name: name,amount: amount)
    }
}

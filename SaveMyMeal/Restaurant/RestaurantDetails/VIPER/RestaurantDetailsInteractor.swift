//
//  RestaurantDetailsInteractor.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/25/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
protocol RestaurantDetailsIteractorProtocol {
    func addToCart(restID:Int,price:Double,count:Int,name:String,amount:Int)
}
class RestaurantDetailsInteractor : RestaurantDetailsIteractorProtocol{
    func addToCart(restID:Int,price:Double,count:Int,name:String,amount:Int){
        cartIDsEntity.append(item: cartItem(id: restID,count: count,amount: amount,price: price,name:name))
    }
}

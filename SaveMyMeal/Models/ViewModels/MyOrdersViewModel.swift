//
//  MyOrdersViewModel.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/9/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import UIKit

class MyOrdersViewModel {
    var orderStatus : Int = 1
    var orderDate : String = ""
    var orderType : String = ""
    var orderID : Int = 0
    var total : String = "0"
    var productName : String = ""
    var rateStars : Double = 0.0
    var rateNumber : String = "(0)"
    var proCount : Int = 0
    var proImage : String = ""
    var restaurant: Restaurant?
    init(MyOrder:OrderModel) {
        restaurant = MyOrder.restaurant
        
        self.orderStatus = MyOrder.orderStatus ?? 1
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+zzzz"
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.timeZone = TimeZone.current
        let createDate = dateFormatter.date(from: MyOrder.created ?? "") ?? Date()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let dateString = dateFormatter.string(from: createDate)
        
        self.orderDate = dateString
        self.orderType = MyOrder.type ?? ""
       
        self.total = String(MyOrder.total ?? 0)
        
        
        self.orderID = MyOrder.id ?? 0
        
        self.proCount = MyOrder.amount ?? 0
       
        self.productName = restaurant?.name ?? ""
       
        self.proImage = restaurant?.logo ?? ""
        
    
        if let ratings = restaurant?.totalRating {
            if !ratings.isEmpty{
               self.rateStars =  Double( ratings[0].stars ?? 0 ) / Double(ratings[0].count ?? 1)
               self.rateNumber = "(\(String(ratings[0].count ?? 0)))"
            }
        }
        
    }
    
}

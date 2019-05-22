//
//  RateRestaurantInteractor.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/6/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
protocol RateRestaurantInteractorProtocol {
    
    func addReview(restID: Int,rate:Int ,comment: String)
}
class RateRestaurantInteractor : RateRestaurantInteractorProtocol{
    func addReview(restID: Int,rate:Int ,comment: String){
        let parameter : [String : String] = [
            "user_id" : "1",
            "restaurant_id" : String(restID),
            "rate" : String(rate),
            "comment" : comment
        ]
        ApiService.SharedInstance.Post(URL: NetworkConstants.addReview, dataarr: [parameter]) { (data) in
            
        }
    }
   
}

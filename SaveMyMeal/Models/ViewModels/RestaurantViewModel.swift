//
//  RestaurantViewModel.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/25/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
class RestaurantViewModel {
    var id : Int = 0
    var amount: Int = 0
    var name: String = ""
    var resLat: Double = 0.0
    var resLong: Double = 0.0
    var distance: Double = 0.0
    var description : String = ""
    var startTimeJoined : String = "00:00"
    var endTimeJoined: String = "00:00"
    var ratingStars: Double = 0.0
    var ratingCount: Int = 0
    var price: Double = 0.0
    var lastPrice: Double = 0.0
    var logo: String = ""
    var coverPhoto: String = ""
    //var reviews: [reviewViewModel] = []
    
    init(data: RestaurantModel) {
        
        self.id  = data.id ?? 0
        self.amount = data.amount ?? 0
        self.name = data.name ?? ""
        self.resLat = data.resLat ?? 0.0
        self.resLong = data.resLong ?? 0.0
        self.price = Double(data.price ?? "0.0") ?? 0.0
        self.lastPrice = Double(data.lastprice ?? 0)
        self.logo = data.logo ?? ""
        self.coverPhoto = data.photo ?? ""
        
        //self.distance =
        self.description = removeHTMLTags(string: data.description ?? "")
        self.startTimeJoined = data.startTimeJoined ?? "00:00"
        self.endTimeJoined = data.endTimeJoined ?? "00:00"
        if var ratings = data.totalRating , !ratings.isEmpty{
            self.ratingStars = (Double(ratings[0].stars ?? 0))/(Double(ratings[0].count ?? 0))
            self.ratingCount = ratings[0].count ?? 0
        }
       //self.reviews = data.reviews?.map({return reviewViewModel(review: $0)}) ?? []
       
        
    }
    func removeHTMLTags(string: String) -> String{
        return string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}



//
//  RestaurantModel.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/24/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
struct RestaurantsModel: Codable {
    let data: [RestaurantModel]?
}

struct RestaurantModel: Codable {
    let id, amount,lastprice: Int?
    let name: String?
    let resLat, resLong: Double?
    let description, startTimeJoined, endTimeJoined: String?
    let price,photo,logo: String?
    let totalRating: [Rating]?
    
    
 //   let reviews: [Review]?
    
    enum CodingKeys: String, CodingKey {
        case id, amount, name,photo,logo
        case resLat = "res_lat"
        case resLong = "res_long"
        case description,price,lastprice
        case startTimeJoined = "start_time_joined"
        case endTimeJoined = "end_time_joined"
        case totalRating = "total_rating"
       // case reviews
    }
}
//struct Review: Codable {
//    let id, restaurantID, userID: Int?
//    let rate, comment,created: String?
//    
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case restaurantID = "restaurant_id"
//        case userID = "user_id"
//        case rate, comment,created
//    }
//}

struct Rating: Codable {
    let restaurantID, stars, count: Int?
    
    enum CodingKeys: String, CodingKey {
        case restaurantID = "restaurant_id"
        case stars, count
    }
}

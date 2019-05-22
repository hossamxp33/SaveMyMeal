//
//  ReviewsModel.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/1/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//


import Foundation

struct ReviewsModel: Codable {
    let data: [ReviewModel]?
    let rate1, rate2, rate3, rate4, rate5: Int?
}

struct ReviewModel: Codable {
    let id: Int?
    let totalRating: [TotalRating]?
    let reviews: [Review]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case totalRating = "total_rating"
        case reviews
    }
}

struct Review: Codable {
    let id: Int?
    let rate : String?
    let comment: String?
    let modified: String?
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case id
        case rate, comment, modified, user
    }
}

struct User: Codable {
    let id: Int?
    let username: String?
}

struct TotalRating: Codable {
    let restaurantID, stars, count: Int?
    
    enum CodingKeys: String, CodingKey {
        case restaurantID = "restaurant_id"
        case stars, count
    }
}

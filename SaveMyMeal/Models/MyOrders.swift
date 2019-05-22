import Foundation

struct OrdersModel: Codable {
    let data: [OrderModel]?
}

struct OrderModel: Codable {
    let id, restaurantID, userID,orderStatus ,amount: Int?
    let total: Int?
    let type: String?
    let created, modified: String?
    let restaurant: Restaurant?
    enum CodingKeys: String, CodingKey {
        case id
        case restaurantID = "restaurant_id"
        case orderStatus = "order_status"
        case userID = "user_id"
        case amount, total, type, created, modified, restaurant
    }
}

struct Restaurant: Codable {
    let id, cityID: Int?
    let description, price, photo,logo: String?
    let resLat, resLong: Double?
    let categoryID: Int?
    let created, modified: String?
    let status: Int?
    let amount: Int?
    let name: String?
    let startTime, endTime: String?
    let totalRating: [TotalRating]?
    enum CodingKeys: String, CodingKey {
        case id
        case cityID = "city_id"
        case description, price, photo, logo
        case resLat = "res_lat"
        case resLong = "res_long"
        case categoryID = "category_id"
        case created, modified, status, amount, name
        case startTime = "start_time"
        case endTime = "end_time"
        case totalRating = "total_rating"
    }
    struct TotalRating: Codable {
        let restaurantID, stars, count: Int?
        
        enum CodingKeys: String, CodingKey {
            case restaurantID = "restaurant_id"
            case stars, count
        }
    }
}



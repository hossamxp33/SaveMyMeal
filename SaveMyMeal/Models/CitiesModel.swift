//
//  CitiesModel.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/24/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
struct CitiesModel: Codable {
    let Cities: [CityModel]?
    enum CodingKeys: String, CodingKey {
        case Cities = "conditions"
    }
}

struct CityModel: Codable {
    let id: Int?
    let name: String?
    let countryID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case countryID = "country_id"
    }
}

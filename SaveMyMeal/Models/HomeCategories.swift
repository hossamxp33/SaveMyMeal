//
//  HomeCategories.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/24/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
struct HomeCategories: Codable {
    let data: [HomeCategory]?
}

struct HomeCategory: Codable {
    let id: Int?
    let name: String?
    //let created, modified: String?
}

//
//  CartRestInfoModel.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/5/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation

struct CartRestInfoModel: Codable {
    let data: [CartRestInfo]?
}

struct CartRestInfo: Codable {
    let name: String?
    let photo: String?
    let logo: String?
    let price: String?
    let amount: Int?
}

//
//  SocialLinks.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/6/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation

struct SocialLinks: Codable {
    let data: [SocialAccount]?
}

struct SocialAccount: Codable {
    let id: Int?
    let link: String?
    let name: String?
}

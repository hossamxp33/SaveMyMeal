//
//  UserProfileModel.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/22/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
struct UserProfileModel: Codable {
    let data: [UserInfo]?
}

// MARK: - User
struct UserInfo: Codable {
    let id, userGroupID: Int?
    let username: String?
    let active, emailVerified: Int?
    let email, mobile: String?
    let created: String?
    let modified: String?
    let firstname, lastname: String?
    let facebookID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userGroupID = "user_group_id"
        case username, active
        case emailVerified = "email_verified"
        case email, mobile, created, modified, firstname, lastname
        case facebookID = "facebook_id"
    }
}

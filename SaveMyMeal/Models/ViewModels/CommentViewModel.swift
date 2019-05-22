//
//  CommentViewModel.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/1/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
class CommentViewModel{
    var rateStars: Double = 0.0
    var comment: String = ""
    var userName: String = ""
    var date: String = ""
    init(review:Review) {
        
        
        rateStars = Double(review.rate ?? "0.0") ?? 0.0
        comment = review.comment ?? ""
        if let user = review.user {
            userName = user.username ?? ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+zzzz"
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.timeZone = TimeZone.current
        let createDate = dateFormatter.date(from: review.modified ?? "") ?? Date()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: createDate)
        
        self.date = dateString
    }
}

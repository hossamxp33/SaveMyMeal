//
//  ReviewViewModel.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/28/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
class reviewViewModel{
    var rateStars : Double = 0.0
    var rateCount : Int = 0
    var commentsCount : Int = 0
    var comments : [CommentViewModel] = []
    
    var ratesCounts : [Int] = []
    
    init(review:ReviewsModel) {
        
        ratesCounts.append(review.rate1 ?? 0)
        ratesCounts.append(review.rate2 ?? 0)
        ratesCounts.append(review.rate3 ?? 0)
        ratesCounts.append(review.rate4 ?? 0)
        ratesCounts.append(review.rate5 ?? 0)
        
        guard let reviewData = review.data , !reviewData.isEmpty else {return}
        
        if let rating = reviewData[0].totalRating , !rating.isEmpty{
            
            rateCount = rating[0].count ?? 0
            rateStars = round((Double(rating[0].stars ?? 0 ) / Double(rateCount)) * 10.0) / 10.0
            
        }
        if let comments_ = reviewData[0].reviews , !comments_.isEmpty{
            commentsCount = comments_.count
            comments = comments_.map({return CommentViewModel(review: $0)})
        }
    }
}

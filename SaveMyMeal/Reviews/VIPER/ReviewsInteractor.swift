//
//  ReviewsInteractor.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/1/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
protocol ReviewsIteractorProtocol {
    
    func getReviews(RestID:Int, completion: @escaping(ReviewsModel?)->())
}
class ReviewsInteractor : ReviewsIteractorProtocol{
    func getReviews(RestID: Int, completion: @escaping (ReviewsModel?) -> ()) {

        var urlString = NetworkConstants.getRestReviews
        
            urlString = urlString + "\(RestID).json"

        print(urlString)

        ApiService.SharedInstance.fetchFeedForUrl(URL: urlString) { (data) in
            do {
                let Reviews = try JSONDecoder().decode(ReviewsModel.self, from: data)

                DispatchQueue.main.async (execute: {

                    if Reviews.data != nil && !Reviews.data!.isEmpty{
                        completion(Reviews)
                    }else{
                        completion(nil)
                    }

                })
            }  catch let jsonErr {
                print(jsonErr)
            }
        }
    }
}

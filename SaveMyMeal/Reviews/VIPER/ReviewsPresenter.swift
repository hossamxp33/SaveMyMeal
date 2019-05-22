//
//  ReviewsPresenter.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/1/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
protocol ReviewsPresenterProtocol {
    func getReviews(restID: Int, completion: @escaping(reviewViewModel)->())
}
class ReviewsPresenter : ReviewsPresenterProtocol {
    var interactor: ReviewsIteractorProtocol
    var router: ReviewsRouterProtocol
    
    init(interactor: ReviewsIteractorProtocol,router: ReviewsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    func getReviews(restID:Int, completion: @escaping(reviewViewModel)->()){
        interactor.getReviews(RestID: restID) { (reviewsData) in
            if reviewsData != nil {
                completion(reviewViewModel(review: reviewsData!))
            }
        }
    }
}

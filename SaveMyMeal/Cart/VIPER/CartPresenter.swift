//
//  CartPresenter.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/5/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
protocol CartPresenterProtocol {
    func getRestInfo(restID: Int, completion: @escaping(RestaurantViewModel?)->())
}
class CartPresenter : CartPresenterProtocol {
    var interactor: CartIteractorProtocol
    var router: CartRouterProtocol
    
    init(interactor: CartIteractorProtocol,router: CartRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    func getRestInfo(restID:Int, completion: @escaping(RestaurantViewModel?)->()){
        interactor.getRestInfo(RestID: restID) { (CartData) in
            if CartData != nil {
                //completion(reviewViewModel(review: CartData!))
                completion(RestaurantViewModel(data: CartData!))
            }
        }
    }
}



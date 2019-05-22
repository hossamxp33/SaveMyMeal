//
//  RateRestaurantPresenter.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/6/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
protocol RateRestaurantPresenterProtocol {
}
class RateRestaurantPresenter : RateRestaurantPresenterProtocol {
    var interactor: RateRestaurantInteractorProtocol
    var router: RateRestaurantRouterProtocol
    
    init(interactor: RateRestaurantInteractorProtocol,router: RateRestaurantRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

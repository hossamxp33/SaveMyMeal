//
//  RestaurantsPresenter.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/25/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
protocol RestaurantsPresenterProtocol {
    func getRestaurants(cityId:Int?,catId: Int?, completion: @escaping([RestaurantViewModel])->())
}
class RestaurantsPresenter : RestaurantsPresenterProtocol {
    
    
    var interactor: RestaurantsIteractorProtocol
    var router: RestaurantsRouterProtocol
    
    init(interactor: RestaurantsIteractorProtocol,router: RestaurantsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    func getRestaurants(cityId:Int?,catId: Int?, completion: @escaping([RestaurantViewModel])->()){
        interactor.getRestaurants(cityId: cityId, catId: catId) { (restaurantsList) in
            completion(self.createRestaurantsViewModels(from: restaurantsList ?? []))
        }
    }
    private func createRestaurantsViewModels(from restaurants: [RestaurantModel]) -> [RestaurantViewModel] {
        var restVMArray = restaurants.map({return RestaurantViewModel(data: $0)})
        restVMArray.sort {
            $0.distance < $1.distance
        }
        return restVMArray
    }
}

//
//  RestaurantsRouter.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/25/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
protocol RestaurantsRouterProtocol {
    
}
class RestaurantsRouter: RestaurantsRouterProtocol{
    var presentingViewController: UIViewController?
    
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    static func createModule(controller:UIViewController) -> RestaurantsPresenterProtocol {
        let interactor: RestaurantsIteractorProtocol = RestaurantsInteractor()
        let router: RestaurantsRouterProtocol = RestaurantsRouter(presentingViewController: controller)
        let presenter: RestaurantsPresenterProtocol  = RestaurantsPresenter(interactor: interactor, router: router)
        return presenter
        
    }
    
    static func navigateToRestaurantsController(cityId:Int?,catId:Int?,controller: UIViewController){
        let presenter =  createModule(controller: controller)
        
        let featuredAppsController = RestaurantsController()
        featuredAppsController.presenter = presenter
        featuredAppsController.cityId = cityId
        featuredAppsController.catId = catId
        controller.navigationController?.pushViewController(featuredAppsController, animated: true)
    }
}

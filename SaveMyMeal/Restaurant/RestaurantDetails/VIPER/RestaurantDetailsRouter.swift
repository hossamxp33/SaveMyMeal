//
//  RestaurantDetailsRouter.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/25/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
protocol RestaurantDetailsRouterProtocol {
    
}
class RestaurantDetailsRouter: RestaurantDetailsRouterProtocol{
    var presentingViewController: UIViewController?
    
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    static func createModule(controller:UIViewController) -> RestaurantDetailsPresenterProtocol {
        let interactor: RestaurantDetailsIteractorProtocol = RestaurantDetailsInteractor()
        let router: RestaurantDetailsRouterProtocol = RestaurantDetailsRouter(presentingViewController: controller)
        let presenter: RestaurantDetailsPresenterProtocol  = RestaurantDetailsPresenter(interactor: interactor, router: router)
        return presenter
        
    }
    
    static func navigateToRestaurantDetailsController(data: RestaurantViewModel,controller: UIViewController){
        let presenter =  createModule(controller: controller)
        
        let featuredAppsController = RestaurantDetailsController()
        featuredAppsController.presenter = presenter
        featuredAppsController.data = data
        controller.navigationController?.pushViewController(featuredAppsController, animated: true)
    }
}


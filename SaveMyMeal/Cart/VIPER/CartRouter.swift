//
//  CartRouter.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/5/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
protocol CartRouterProtocol {
    
}
class CartRouter: CartRouterProtocol{
    var presentingViewController: UIViewController?
    
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    static func createModule(controller:UIViewController) -> CartPresenterProtocol {
        let interactor: CartIteractorProtocol = CartInteractor()
        let router: CartRouterProtocol = CartRouter(presentingViewController: controller)
        let presenter: CartPresenterProtocol  = CartPresenter(interactor: interactor, router: router)
        return presenter
        
    }
    
    static func navigateToCartController(restID:Int,controller: UIViewController){
        let presenter =  createModule(controller: controller)
        
        let featuredAppsController = CartController()
        featuredAppsController.presenter = presenter
        //featuredAppsController.restID = restID
        //  featuredAppsController.CartData = Cart
        
        controller.navigationController?.pushViewController(featuredAppsController, animated: true)
    }
}

//
//  HomeRouter.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/24/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
protocol HomeRouterProtocol {
    
}
class HomeRouter: HomeRouterProtocol{
    var presentingViewController: UIViewController?
    
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    static func createModule(controller:UIViewController) -> HomePresenterProtocol {
        let interactor: HomeIteractorProtocol = HomeInteractor()
        let router: HomeRouterProtocol = HomeRouter(presentingViewController: controller)
        let presenter: HomePresenterProtocol  = HomePresenter(interactor: interactor, router: router)
        return presenter
        
    }
    
    static func navigateToHomeController(controller: UIViewController){
        let presenter =  createModule(controller: controller)
        
        let featuredAppsController = HomeController()
        featuredAppsController.presenter = presenter
        controller.navigationController?.pushViewController(featuredAppsController, animated: true)
    }
}

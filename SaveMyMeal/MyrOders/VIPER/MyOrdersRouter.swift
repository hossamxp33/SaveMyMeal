//
//  MyOrdersRouter.swift
//  ShopGate
//
//  Created by Hadeer Kamel on 4/9/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
protocol MyOrdersRouterProtocol {
    
}
class MyOrdersRouter: MyOrdersRouterProtocol{
    var presentingViewController: UIViewController?
    
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    static func createModule(controller:UIViewController) -> MyOrderPresenterProtocol {
        let interactor: MyOrdersIteractorProtocol = MyOrdersInteractor()
        let router:MyOrdersRouterProtocol = MyOrdersRouter(presentingViewController: controller)
        let presenter: MyOrderPresenterProtocol  = MyOrderPresenter(interactor: interactor, router: router)
        return presenter
        
    }
    
    static func navigateToMyOrdersController(controller: UIViewController){
        let presenter =  createModule(controller: controller)
        let layout = UICollectionViewFlowLayout()
        let featuredAppsController = MyOrderController()
        featuredAppsController.presenter = presenter
        controller.navigationController?.pushViewController(featuredAppsController, animated: true)
    }
}

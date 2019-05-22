//
//  RateRestaurantRouter.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/28/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
protocol RateRestaurantRouterProtocol {
    
}
class RateRestaurantRouter: RateRestaurantRouterProtocol{
    var presentingViewController: UIViewController?
    
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    
    static func navigateToRateRestaurantController(logo:UIImage,restName:String,restID:Int,controller: UIViewController){
     //   let presenter =  createModule(controller: controller)
        
        let featuredAppsController = RateRestaurantController()
      //  featuredAppsController.presenter = presenter
        featuredAppsController.restID = restID
        featuredAppsController.logoImage = logo
        featuredAppsController.restName = restName
        
        controller.navigationController?.pushViewController(featuredAppsController, animated: true)
    }
}


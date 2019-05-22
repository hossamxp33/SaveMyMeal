//
//  ReviewsRouter.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/28/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
protocol ReviewsRouterProtocol {
    
}
class ReviewsRouter: ReviewsRouterProtocol{
    var presentingViewController: UIViewController?
    
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    static func createModule(controller:UIViewController) -> ReviewsPresenterProtocol {
        let interactor: ReviewsIteractorProtocol = ReviewsInteractor()
        let router: ReviewsRouterProtocol = ReviewsRouter(presentingViewController: controller)
        let presenter: ReviewsPresenterProtocol  = ReviewsPresenter(interactor: interactor, router: router)
        return presenter

    }
    
    static func navigateToReviewsController(logo:UIImage,restID:Int,controller: UIViewController){
        let presenter =  createModule(controller: controller)
        
        let featuredAppsController = ReviewsController()
        featuredAppsController.presenter = presenter
        featuredAppsController.restID = restID
        featuredAppsController.logo = logo
     //  featuredAppsController.reviewsData = reviews
        
        controller.navigationController?.pushViewController(featuredAppsController, animated: true)
    }
}

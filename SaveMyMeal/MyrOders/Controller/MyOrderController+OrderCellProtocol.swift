//
//  MyOrderController+OrderCellProtocol.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/7/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit

protocol orderCellToControllerProtocol {
    func navigateToRateRestaurantController(logo: UIImage,restName: String, restID: Int)
    func presentAlert(title:String,message:String)
}
extension MyOrderController : orderCellToControllerProtocol{
    func navigateToRateRestaurantController(logo: UIImage,restName: String ,restID: Int){
        RateRestaurantRouter.navigateToRateRestaurantController(logo: logo, restName: restName, restID: restID, controller: self)
    }
    func presentAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}

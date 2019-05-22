//
//  MyOrdersInteractor.swift
//  ShopGate
//
//  Created by Hadeer Kamel on 4/9/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import UIKit

protocol MyOrdersIteractorProtocol {
    func getMyOrders(userID:Int,completion: @escaping([OrderModel]) -> Void)
    
}
class MyOrdersInteractor: MyOrdersIteractorProtocol{
   
    func getMyOrders(userID: Int,completion: @escaping([OrderModel]) -> Void){
        ApiService.SharedInstance.fetchFeedForUrl(URL: NetworkConstants.getUserOrders + "\(String(userID)).json"){ (dataa) in
            do {
                
                print(dataa)
                var myOrders = try JSONDecoder().decode(OrdersModel.self, from: dataa)
                
                DispatchQueue.main.async (execute: {
                
                      completion(myOrders.data ?? [])
                  
                })
            }  catch let jsonErr {
                print(jsonErr)
            }
        }
    }
    
    
    
    
}

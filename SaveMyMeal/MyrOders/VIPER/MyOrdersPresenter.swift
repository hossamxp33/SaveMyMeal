//
//  MyOrdersPresenter.swift
//  ShopGate
//
//  Created by Hadeer Kamel on 4/9/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit

protocol MyOrderPresenterProtocol {
    func getMyOrders(id:Int,completion: @escaping ([MyOrdersViewModel]) -> Void)
    
}

class MyOrderPresenter: MyOrderPresenterProtocol{
   
    var interactor: MyOrdersIteractorProtocol
    var router: MyOrdersRouterProtocol
    
    init(interactor: MyOrdersIteractorProtocol,router:MyOrdersRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func getMyOrders(id: Int, completion: @escaping ([MyOrdersViewModel]) -> Void) {
        interactor.getMyOrders(userID: id) { (orders) in
            completion(self.createMyOrderViewModels(from: orders))
        }
    }
    
    private func createMyOrderViewModels(from orders: [OrderModel]) -> [MyOrdersViewModel] {
        return orders.map({return MyOrdersViewModel(MyOrder: $0)}) 
    }
    
}

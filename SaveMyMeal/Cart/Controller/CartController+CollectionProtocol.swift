//
//  CartController+CollectionProtocol.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/6/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
protocol CartCollectionViewProtocol{
    func refreshForItemRemovedWith(id:Int)
    func updateTotal()
}
extension CartController : CartCollectionViewProtocol{
   
    func refreshForItemRemovedWith(id:Int){
        //remove
        //let index =  self.cartData.firstIndex(where: { $0.id == id }) ?? 0
        let index = self.cartData.indices.filter{ cartData[$0].id == id }.first ?? 0
        self.cartData.remove(at: index)
        self.productsCollectionView.reloadData()
        updateTotal()
        self.setCartBadge()
        
    }
    func updateTotal(){
        self.total = cartIDsEntity.cartTotal
    }
}

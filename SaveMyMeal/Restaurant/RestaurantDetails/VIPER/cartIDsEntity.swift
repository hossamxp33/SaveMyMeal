//
//  cartIDsEntity.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/1/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
//typealias cartItem = (id:Int, count:Int, price:Double)
struct cartItem:Codable {
    let id,count,amount: Int?
    let price: Double?
    let name: String?
}
class cartIDsEntity {
    
    private static var cartTotal_ : Double!
    internal static var cartTotal : Double!
    {
        get
        {
            if cartTotal_ != nil
            { return cartTotal_}
            let val = UserDefaults.standard.object(forKey: "cartTotal")
            if val == nil {return 0}
            return ( val as! Double)
        }
        set
        {
            cartTotal_ = newValue as Double?
            UserDefaults.standard.setValue(newValue, forKey: "cartTotal")
            UserDefaults.standard.synchronize();
        }
    }
    
    private static var cartCount_ : Int!
    internal static var cartCount : Int!
    {
        get
        {
            if cartCount_ != nil
            { return cartCount_}
            let val = UserDefaults.standard.object(forKey: "cartCount")
            if val == nil {return 0}
            return ( val as! Int)
        }
        set
        {
            cartCount_ = newValue as Int?
            UserDefaults.standard.setValue(newValue, forKey: "cartCount")
            UserDefaults.standard.synchronize();
        }
    }
    private static var cartItems_ : [cartItem]!
    internal static var cartItems : [cartItem]!
    {
        get
        {
            if cartItems_ != nil
            { return cartItems_}
            return load()
            
        }
        set
        {
            cartItems_ = newValue as [cartItem]?
            save(newValue)
        }
    }
    private static func save(_ items: [cartItem]) {
        let data = items.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: "cartItems")
    }
    
    private static func load() -> [cartItem] {
        guard let encodedData = UserDefaults.standard.array(forKey: "cartItems") as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(cartItem.self, from: $0) }
    }
    static func append(item:cartItem){
         cartIDsEntity.cartItems.append(item)
         cartIDsEntity.cartItems =  cartIDsEntity.cartItems
        // edit the total
          // add the price
        cartIDsEntity.cartTotal = Double(cartIDsEntity.cartTotal) + (item.price! * Double(item.count!))
        cartIDsEntity.cartCount = cartIDsEntity.cartCount + 1
        print(cartItems)
    }
    static func remove(id:Int){
        
        getItem(of: id) { (index, item) in
            if let item = item {
                cartIDsEntity.cartItems.remove(at: index)
        
                cartIDsEntity.cartTotal = Double(cartIDsEntity.cartTotal) - (Double(item.count! ) * (item.price!))
                
                cartIDsEntity.cartCount = cartIDsEntity.cartCount - 1

            }
        }
    }
    static func IncreaseCount(of id: Int){
        getItem(of: id) { (index, item) in
            if let item = item {
                cartIDsEntity.cartItems[index] = cartItem(id: item.id,count: item.count!+1,amount:item.amount, price: item.price,name: item.name)
            cartIDsEntity.cartItems = cartIDsEntity.cartItems
            
            cartIDsEntity.cartTotal = Double(cartIDsEntity.cartTotal) +  (item.price!)
            }
        }
    }
    static func decreaseCount(of id: Int){
        getItem(of: id) { (index, item) in
            if let item = item {
                cartIDsEntity.cartItems[index] = cartItem(id: item.id,count: item.count!-1,amount:item.amount,price: item.price,name: item.name)
            cartIDsEntity.cartItems = cartIDsEntity.cartItems
            cartIDsEntity.cartTotal = Double(cartIDsEntity.cartTotal) -  (item.price!)
            }
        }
    }
    static func getItem(of id: Int ,complition: @escaping(_ index:Int,_ item:cartItem?)->()){
        let index =  cartIDsEntity.cartItems.firstIndex(where: { $0.id == id }) ?? -1
        if index != -1{
            let item  = cartIDsEntity.cartItems[index]
            complition(index,item)
        }else{
            complition(index,nil)
        }
    }
    static func changeAmount(id: Int,amount:Int){
        getItem(of: id) { (index, item) in
            if let item = item {
                cartIDsEntity.cartItems[index] = cartItem(id: item.id,count: item.count,amount: amount,price: item.price,name: item.name)
            }
        }
    }
    static func clear(){
        cartIDsEntity.cartTotal = 0.0
        cartIDsEntity.cartCount = 0
        cartIDsEntity.cartItems = []
    }
}

//
//  CartInteractor.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/5/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//
import Foundation
protocol CartIteractorProtocol {
    
    func getRestInfo(RestID:Int, completion: @escaping(RestaurantModel?)->())
}
class CartInteractor : CartIteractorProtocol{
    func getRestInfo(RestID: Int, completion: @escaping (RestaurantModel?) -> ()) {

        var urlString = NetworkConstants.getRestInfo

        urlString = urlString + "\(RestID).json"

        print(urlString)

        ApiService.SharedInstance.fetchFeedForUrl(URL: urlString) { (data) in
            do {
                let Cart = try JSONDecoder().decode(RestaurantsModel.self, from: data)

                DispatchQueue.main.async (execute: {

                    if Cart.data != nil && !Cart.data!.isEmpty{
                        completion(Cart.data![0])
                    }else{
                        completion(nil)
                    }

                })
            }  catch let jsonErr {
                print(jsonErr)
            }
        }
    }
}

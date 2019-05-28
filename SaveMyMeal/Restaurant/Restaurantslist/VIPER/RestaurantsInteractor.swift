//
//  RestaurantsInteractor.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/25/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation

protocol RestaurantsIteractorProtocol {
   
    func getRestaurants(cityId:Int?,catId: Int?, completion: @escaping([RestaurantModel]?)->())
}
class RestaurantsInteractor : RestaurantsIteractorProtocol{
    
    func getRestaurants(cityId:Int?,catId: Int?, completion: @escaping([RestaurantModel]?)->()){
        
        var urlString = ""
        
        if cityId != nil{
            urlString = NetworkConstants.getRestaurants + "/\(cityId!)"
        }else {
            
            urlString = NetworkConstants.getRestByCatID + "/\(catId!)"
            
        }
        
        urlString = urlString + ".json"
        
        print(urlString)
        ApiService.SharedInstance.fetchFeedForUrl(URL: urlString) { (data) in
            do {
                let restaurants = try JSONDecoder().decode(RestaurantsModel.self, from: data)
                
                DispatchQueue.main.async (execute: {
                    
                    completion(restaurants.data)
                    
                })
            }  catch let jsonErr {
                print(jsonErr)
            }
        }
    }
}

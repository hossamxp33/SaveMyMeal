//
//  HomeInteractor.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/24/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
protocol HomeIteractorProtocol {
    func getCategories(completion: @escaping([HomeCategory]?)->())
    func searchCountry(keyWord:String,completion: @escaping([CityModel]?)->())
    
}
class HomeInteractor : HomeIteractorProtocol{
    
    func getCategories(completion: @escaping([HomeCategory]?)->()){
        
        ApiService.SharedInstance.fetchFeedForUrl(URL: NetworkConstants.getCategories) { (data) in
            do {
                let categories = try JSONDecoder().decode(HomeCategories.self, from: data)
                
                DispatchQueue.main.async (execute: {
                    
                    completion(categories.data)
                    
                })
            }  catch let jsonErr {
                print(jsonErr)
            }
        }
        
    }
    
    func searchCountry(keyWord:String,completion: @escaping([CityModel]?)->()){
        let parameters : [String:String] = [
            "name": keyWord
        ]
        ApiService.SharedInstance.Post(URL: NetworkConstants.searchCity, dataarr: parameters) { (data) in
            do {
                
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                let cities = try JSONDecoder().decode(CitiesModel.self, from: jsonData )
                
                DispatchQueue.main.async (execute: {
                    
                    completion(cities.Cities)
                    
                })
            }  catch let jsonErr {
                print(jsonErr)
            }
        }
    }
    
    
    
}

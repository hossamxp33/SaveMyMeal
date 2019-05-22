//
//  HomePresenter.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/24/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
protocol HomePresenterProtocol {
    func getHomeCategories(completion: @escaping([HomeCategoriesViewModel]?)->())
    func searchCityByWord(keyWord:String,completion: @escaping([CityModel]?,[String]?)->())
}
class HomePresenter : HomePresenterProtocol {
    
    
    var interactor: HomeIteractorProtocol
    var router: HomeRouterProtocol
    
    init(interactor: HomeIteractorProtocol,router: HomeRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func getHomeCategories(completion: @escaping([HomeCategoriesViewModel]?)->()){
        interactor.getCategories { (categories) in
            completion(self.createCategoriesViewModels(from: categories ?? []))
        }
    }
    private func createCategoriesViewModels(from categories: [HomeCategory]) -> [HomeCategoriesViewModel] {
        return categories.map({return HomeCategoriesViewModel(data: $0)})
    }
    func searchCityByWord(keyWord:String,completion: @escaping([CityModel]?,[String]?)->()){
        interactor.searchCountry(keyWord: keyWord) { (cities) in
            let citiesNamesArray = cities?.map {$0 .name ?? ""}
            completion(cities, citiesNamesArray)
        }
    }
    
}

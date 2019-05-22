//
//  RestaurantsController.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/17/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
class RestaurantsController : BaseViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    var cell = "cell"
    var presenter : RestaurantsPresenterProtocol?
    var catId : Int?
    var cityId : Int?
    var restaurants : [RestaurantViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil{
            presenter = RestaurantsRouter.createModule(controller: self)
        }
        restaurantsCollectionView.register(RestaurantViewCell.self, forCellWithReuseIdentifier: cell)
        restaurantsCollectionView.delegate = self
        restaurantsCollectionView.dataSource = self
        
        
        presenter?.getRestaurants(cityId:cityId, catId: catId, completion: { (data) in
            self.restaurants = data
            self.restaurantsCollectionView.reloadData()
        })
    }
    //MARK: - CollectionView -
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if restaurants.isEmpty {
            emptyRestaurantsLabel.isHidden = false
        }else{
            emptyRestaurantsLabel.isHidden = true
        }
        return restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! RestaurantViewCell
        cell.data = restaurants[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat(collectionView.frame.size.width), height: 200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     //   self.navigationController?.pushViewController(RestaurantDetailsController(), animated: true)
        RestaurantDetailsRouter.navigateToRestaurantDetailsController(data: restaurants[indexPath.row], controller: self)
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.backgroundColor = UIConstants.AppBGColor
        
        view.addSubview(restaurantsCollectionView)
        restaurantsCollectionView.topAnchor.constraint(equalTo:navigationView.bottomAnchor , constant: 10).isActive = true
        restaurantsCollectionView.rightAnchor.constraint(equalTo:view.rightAnchor , constant: -10).isActive = true
        restaurantsCollectionView.leftAnchor.constraint(equalTo:view.leftAnchor , constant: 10).isActive = true
        restaurantsCollectionView.bottomAnchor.constraint(equalTo:view.bottomAnchor ).isActive = true
        
        restaurantsCollectionView.addSubview(emptyRestaurantsLabel)
        emptyRestaurantsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyRestaurantsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    let restaurantsCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = false
        layout?.scrollDirection = .vertical
        layout?.minimumLineSpacing = 0
        layout?.minimumInteritemSpacing = 0
        collectionView.bounces = false
        collectionView.scrollIndicatorInsets = .zero
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
    
        return collectionView
    }()
    let emptyRestaurantsLabel : UILabel = {
        let label = UILabel()
        label.text = "There is no restaurants"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIConstants.LightFont.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

}

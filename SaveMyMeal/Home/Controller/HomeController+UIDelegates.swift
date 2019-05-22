//
//  HomeController+CollectionDelegate.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/24/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
//MARK: - Collection View -

extension HomeController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! PassionView
        cell.title = categories[indexPath.row].title
        cell.selected_ = categories[indexPath.row].selected
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat((collectionView.frame.size.width)-(10*2))/3.0, height: 30)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // navigationController?.pushViewController(RestaurantsController(), animated: true)
        //Just setSelected
        categories[selectedCategoryIndex].selected = false
        categories[indexPath.row].selected = true
        selectedCategoryIndex = indexPath.row
        selectedCategoryId = categories[indexPath.row].id
        
        collectionView.reloadData()
    }
}

//MARK: - SearchBar -

extension HomeController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        dropDown.show()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        dropDown.hide()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            searchCity(keyWord: searchText)
        }else{
            dropDown.dataSource = []
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text , searchText != "" {
            searchCity(keyWord: searchText)
        }else{
            dropDown.dataSource = []
        }
    }
}

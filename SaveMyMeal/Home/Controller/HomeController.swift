//
//  HomeController.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/15/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import UIKit
import DropDown

class HomeController: BaseViewController {

    var cell = "cell"
    var categories : [HomeCategoriesViewModel] = []
    var selectedCategoryId : Int?
    var selectedCategoryIndex : Int = 0
    var presenter : HomePresenterProtocol?
    var cities : [CityModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil{
            presenter = HomeRouter.createModule(controller: self)
        }
        init_()
        citiesDropDownSelection()
        getHomeCategories()
    }
   
    func init_(){
        passionCollectionView.register(PassionView.self, forCellWithReuseIdentifier: cell)
        passionCollectionView.delegate = self
        passionCollectionView.dataSource = self
        
        searchBar.delegate = self
        
        self.backButton.isHidden = true
    }
    func citiesDropDownSelection(){
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.searchBar.text = self.cities[index].name
           // self.navigationController?.pushViewController(RestaurantsController(), animated: true)
            self.dropDown.hide()
            RestaurantsRouter.navigateToRestaurantsController(cityId: self.cities[index].id, catId: self.selectedCategoryId, controller: self)
        }
    }
    func getHomeCategories(){
        presenter?.getHomeCategories(completion: { (categories) in
          //  print(categories)
            self.categories = categories ?? []
            
            self.passionCollectionView.reloadData()
        })
    }
    func searchCity(keyWord:String){
        presenter?.searchCityByWord(keyWord: keyWord, completion: { (cities, citiesNames) in
            self.cities = cities ?? []
            self.dropDown.dataSource = citiesNames ?? []
            self.dropDown.show()
        })
    }



    override func setupViews(){
        super.setupViews()
        view.backgroundColor = .white
        
        view.addSubview(BGImage)
        BGImage.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        BGImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        BGImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        BGImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        view.addSubview(selectAreaView)
        selectAreaView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 70).isActive = true
        selectAreaView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        selectAreaView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        selectAreaView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        selectAreaView.addSubview(selectAreaLabel)
        selectAreaLabel.topAnchor.constraint(equalTo: selectAreaView.topAnchor, constant: 20).isActive = true
        selectAreaLabel.rightAnchor.constraint(equalTo: selectAreaView.rightAnchor).isActive = true
        selectAreaLabel.leftAnchor.constraint(equalTo: selectAreaView.leftAnchor).isActive = true

        selectAreaView.addSubview(searchBar)
        searchBar.widthAnchor.constraint(equalTo: selectAreaView.widthAnchor, multiplier: 0.9).isActive = true
        searchBar.topAnchor.constraint(equalTo: selectAreaLabel.bottomAnchor, constant: 10).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: selectAreaView.centerXAnchor).isActive = true

        dropDown.anchorView = searchBar
        dropDown.bottomOffset = CGPoint(x: 0, y: 45)

        view.addSubview(pickYourPassionLabel)
        pickYourPassionLabel.topAnchor.constraint(equalTo: selectAreaView.bottomAnchor, constant: 30).isActive = true
        pickYourPassionLabel.rightAnchor.constraint(equalTo: selectAreaView.rightAnchor,constant: -20).isActive = true
        pickYourPassionLabel.leftAnchor.constraint(equalTo: selectAreaView.leftAnchor,constant: 20).isActive = true


        view.addSubview(passionCollectionView)
        passionCollectionView.topAnchor.constraint(equalTo: pickYourPassionLabel.bottomAnchor, constant: 30).isActive = true
        passionCollectionView.rightAnchor.constraint(equalTo: pickYourPassionLabel.rightAnchor).isActive = true
        passionCollectionView.leftAnchor.constraint(equalTo: pickYourPassionLabel.leftAnchor).isActive = true
        passionCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    //BGImage
    let BGImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "backgroung")
        imageView.alpha = 0.4
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    //AreaView
    let selectAreaView : UIView = {
        let view  = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = .zero
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //select area label
    let selectAreaLabel : UILabel = {

        let label = UILabel()
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(16)
        label.text = "Enter Your Area"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //AreaSearchBar
    let searchBar : UISearchBar = {

        let searchBar = UISearchBar()
        searchBar.placeholder = "Nasrcity,Heliopolis,,etc"
        searchBar.backgroundColor = #colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)
        searchBar.barTintColor = #colorLiteral(red: 0.8469662666, green: 0.8471121192, blue: 0.8469570279, alpha: 1)
        searchBar.backgroundImage = UIImage()
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        let placeholderLabel = textFieldInsideUISearchBar?.value(forKey: "placeholderLabel") as? UILabel
        placeholderLabel?.font = UIConstants.LightFont.withSize(13.0)
        placeholderLabel?.textColor = .darkGray
        textFieldInsideUISearchBar?.leftView = UIImageView(image: #imageLiteral(resourceName: "search"))
        textFieldInsideUISearchBar?.font = UIConstants.LightFont.withSize(15.0)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    //passionLabel
    let pickYourPassionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(17)
        label.textColor = #colorLiteral(red: 0.2861464024, green: 0.2903043926, blue: 0.2861197591, alpha: 1) 
        label.text = "pick your passion .."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //passionsCollectionView
    let passionCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = false
        layout?.scrollDirection = .vertical

        collectionView.bounces = false
        collectionView.scrollIndicatorInsets = .zero
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    let dropDown : DropDown = {
        let dropDown = DropDown()
        dropDown.dataSource = []
        dropDown.direction = .bottom
        dropDown.separatorColor = .darkGray
        dropDown.cellHeight = 25
        dropDown.textFont = dropDown.textFont.withSize(13)
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        return dropDown
    }()


    
}

//
//  MainViewController.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/24/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UITabBarController {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLocation()
        
       // let layout = UICollectionViewFlowLayout()
        
       let  firstTabNavigationController = UINavigationController.init(rootViewController: HomeController())
       let  secondTabNavigationControoller = UINavigationController.init(rootViewController: MyOrderController())
       let  thirdTabNavigationController = UINavigationController.init(rootViewController: CartController())
       let  fourthTabNavigationControoller = UINavigationController.init(rootViewController: MoreController())
        
        
       // vc = MainMenuController(collectionViewLayout:layout)
        
        //////
        
        self.viewControllers = [firstTabNavigationController, secondTabNavigationControoller, thirdTabNavigationController,fourthTabNavigationControoller]
        let item1 = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), tag: 0)
        let item2 = UITabBarItem(title: "Orders", image: #imageLiteral(resourceName: "shopping-cart (1)") , tag: 1)
        let item3 = UITabBarItem(title: "Cart", image: #imageLiteral(resourceName: "shopping-cart (1)") , tag: 2)
        let item4 = UITabBarItem(title: "More", image:#imageLiteral(resourceName: "more") , tag: 3)

        item3.badgeValue = (cartIDsEntity.cartCount == 0) ? nil : String(cartIDsEntity.cartCount)
        
        
        firstTabNavigationController.tabBarItem = item1
        secondTabNavigationControoller.tabBarItem = item2
        thirdTabNavigationController.tabBarItem = item3
        fourthTabNavigationControoller.tabBarItem = item4
        //fifthTabNavigationController.tabBarItem = item5
        self.selectedViewController = firstTabNavigationController
        UITabBar.appearance().tintColor = UIConstants.AppColor
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIConstants.LightFont.withSize(11)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIConstants.LightFont.withSize(11)], for: .selected)
        self.tabBar.unselectedItemTintColor = .black
        
        

    }
    
    func initLocation(){
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

}

extension  MainViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        UserData.location = manager.location ?? CLLocation()
    }
}

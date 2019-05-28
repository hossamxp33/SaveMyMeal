//
//  MoreController.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/9/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class MoreController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    let tableCell = "MoreCell"
    var moreMenu : [(title: String,action: ()->())] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.tableCell)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.backButton.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        loadMenuData()
    }
    func loadMenuData(){
        moreMenu = []
        if !LoginModel.isLogged{
            
            moreMenu.append((title: "Login", action: self.pushLogin))
            moreMenu.append((title: "Register", action: self.pushRegister))
        }else{
            moreMenu.append((title: "Profile", action: self.pushProfile))
            moreMenu.append((title: "LogOut", action: self.logOut))
        }
        moreMenu.append((title: "ContactUs", action: self.pushContactUs))
        self.tableView.reloadData()
    }
    //MARK: - Actions -
    func pushLogin(){
        self.navigationController?.pushViewController(LoginController().self, animated: true)
    }
    func pushRegister(){
        self.navigationController?.pushViewController(RegisterController().self, animated: true)
    }
    func pushContactUs(){
        self.navigationController?.pushViewController(ContactUsController().self, animated: true)
    }
    func pushProfile(){
        let VC = RegisterController().self
        VC.mode = .Profile
        self.navigationController?.pushViewController(VC, animated: true)
    }
    func logOut(){
        LoginModel.UserId = nil
        LoginModel.UserToken = nil
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        loadMenuData()
        
    }
    //MARK: - tableView -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath)
        cell.textLabel?.text = moreMenu[indexPath.row].title
        cell.textLabel?.font = UIConstants.LightFont.withSize(17)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moreMenu[indexPath.row].action()
    }
    
    
   
    override func setupViews() {
        super.setupViews()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)
        ])
    }
    //table view
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
}

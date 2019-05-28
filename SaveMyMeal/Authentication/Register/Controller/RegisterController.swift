//
//  RegisterController.swift
//  ShopGate
//
//  Created by Hadeer Kamel on 4/10/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookCore
import FacebookLogin

enum registerVCMode {
    case Register
    case Profile
}

class RegisterController: BaseViewController , FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if !result.isCancelled {
            getFBUserData()
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    


    var mode : registerVCMode = .Register
    var data : UserInfo?{
        didSet{
            if data == nil{ return }
            userNameTextField.text = data?.username ?? "--"
            firstNameTextField.text = data?.firstname ?? "--"
            lastNameTextField.text = data?.lastname ?? "--"
            emailTextField.text = data?.email ?? "--"
            phoneTextField.text = data?.mobile ?? "--"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookLoginButton.readPermissions = ["public_profile","email"]
        facebookLoginButton.delegate = self
        if mode == .Profile {
            setupAsProfile()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var contentRect = CGRect.zero
        
        for view in contentView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        scrollView.contentSize = CGSize(width:contentRect.size.width, height: contentRect.size.height + 20)
      //  self.scrollView.contentSize = CGSize(width:self.view.frame.width, height: contentView.frame.height)
    }
    func setupAsProfile(){
        //PrepareUI
        passwordTextField.isHidden = true
        //userNameTextField.isUserInteractionEnabled = false
       // firstNameTextField.isUserInteractionEnabled = false
       // lastNameTextField.isUserInteractionEnabled = false
       // emailTextField.isUserInteractionEnabled = false
      //  phoneTextField.isUserInteractionEnabled = false
       
        facebookLoginButton.isHidden = true
        
        registerButton.setTitle("Edit", for: .normal)
        //load profile data
        loadUserData()
        
        
        //populate ui
//        userNameTextField.text = data.username
//        firstNameTextField.text = data.fristName
//        lastNameTextField.text = data.lastName
//        emailTextField.text = data.email
//        phoneTextField.itext = data.phone
    }
    func loadUserData(){
        print(LoginModel.UserId)
        let url = NetworkConstants.getProfile + String(LoginModel.UserId) + ".json"
        ApiService.SharedInstance.fetchFeedForUrl(URL: url){ resposeData in
            do {
                let userData = try JSONDecoder().decode(UserProfileModel.self, from: resposeData)
                
                DispatchQueue.main.async (execute: {
                    if userData.data != nil && !userData.data!.isEmpty  {
                       self.data = userData.data?[0]
                    }
                    
                })
            }  catch let jsonErr {
                print(jsonErr)
            }
            
        }
    }
    //MARK: - Buttons Actions -
    @objc func registerButtonClicked(){
        guard let username = userNameTextField.text, username != "" else {
            //alert enter username
            
            showWarningMessages(body: "Username Required")
            return
        }
        if username.count < 8 {
            showWarningMessages(body: "Username shouldn't be less than 8 charachters")
            return
        }
        guard let fristname = firstNameTextField.text, fristname != "" else{
            showWarningMessages(body:"Frist name required")
            return
        }
        guard let lastname = lastNameTextField.text, lastname != "" else{
            showWarningMessages(body:"Last name required")
            return
        }
        
        
        guard let email = emailTextField.text, email != "" else {
            //alert Please confirm password
            showWarningMessages(body:"Email Required")
            return
        }
        guard let phone = phoneTextField.text, phone != "" else{
            showWarningMessages(body:"Phone number required")
            return
        }
        if mode == .Register {
            guard let password = passwordTextField.text, password != "" else {
                //alert enter passsword
                showWarningMessages(body:"Password Required")
                return
            }
            if  password.count < 8 {
                showWarningMessages(body: "Password shouldn't be less than 8 charachters")
                return
            }
            registerAPI(username: username,firstname: fristname,lastname: lastname,email: email,password: password,phone: phone){
                success in}
        }else{
            editAPI(username: username, firstname: fristname, lastname: lastname, email: email, phone: phone)
        }
    }
    func editAPI(username: String,firstname: String,lastname: String,email:String,phone: String? = nil){
        var parameters : [String:String] = [
            "username" : username,
            "firstname" : firstname,
            "lastname" : lastname,
            "email" : email
            ]
        if phone != nil { parameters["mobile"] = phone }
        
        let url = NetworkConstants.editProfile + String(LoginModel.UserId) + ".json"
        
        ApiService.SharedInstance.Login(URL: url, dataarr: parameters) { (data) in
            print(data)
            let success = data["success"] as? Bool
            
            if !success! {
                showErrorMessage(body: "Username Or Email is already exist")
                
            }else{
                
                showSuccessMessage(body: "Congrats,,Your info Updated successfully")
                
                self.navigationController?.popViewController(animated: true)
                
            }
            
        }
        
    }
    func registerAPI(username: String,firstname: String,lastname: String,email:String, password: String? = nil ,phone: String? = nil,facebook_id : String? = nil , complition: @escaping (_ success: Bool)->()){
        var parameters : [String:String] = [
            "username" : username,
            "firstname" : firstname,
            "lastname" : lastname,
            "email" : email,
            "active" : "1",
            "email_verified" : "1",
            "user_group_id" : "1",
            ]
        if phone != nil { parameters["mobile"] = phone }
        if password != nil { parameters["password"] = password }
        if facebook_id != nil { parameters["facebook_id"] = facebook_id}
    
        
        ApiService.SharedInstance.Login(URL: NetworkConstants.register, dataarr: parameters) { (data) in
            print(data)
            let response = LoginModel(response: data)
            
            if !response.success! {
                showErrorMessage(body: "Username Or Email is already exist")
                complition(false)
            }else{
                // let id = data["id"] as! Int
                // let token = data["token"] as! String
                showSuccessMessage(body: "Congrats,,Registration completed successfully")
                complition(true)
                self.navigationController?.popViewController(animated: true)
                
            }
            
        }
    }
    @objc func FBLoginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile ,.email], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.getFBUserData()
            }
            
        }
    }
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, first_name, last_name"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let dict = result as! [String : String]
                    //print(result!)
                    print(dict)
                    self.registerAPI(username: dict["name"] ?? "", firstname: dict["first_name"] ?? "", lastname: dict["last_name"] ?? "", email: dict["email"] ?? "",facebook_id: dict["id"] ?? "") {
                        success in
                        if !success {
                            let loginManager = FBSDKLoginManager()
                            loginManager.logOut()
                        }
                    }
                    
                }else{
                    print(error)
                    let loginManager = FBSDKLoginManager()
                    loginManager.logOut()
                }
            })
        }
    }
    override func setupViews(){
        super.setupViews()
        
        self.view.backgroundColor = UIConstants.AppBGColor
        
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        self.scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            //contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        
        
        
        self.contentView.addSubview(logoImage)
        logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
        logoImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.17).isActive = true
        logoImage.widthAnchor.constraint(equalTo: logoImage.heightAnchor, multiplier: 1).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        
        self.contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.55).isActive = true
        
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(firstNameTextField)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(phoneTextField)
        
        self.contentView.addSubview(registerButton)
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        registerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 25).isActive = true
        
        
        self.contentView.addSubview(facebookLoginButton)
        facebookLoginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        facebookLoginButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7).isActive = true
        facebookLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        facebookLoginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 5).isActive = true
        facebookLoginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    //MARK: - UI Compontns -
    
    
    let contentView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let logoImage : CustomImageView = {
        let image = CustomImageView()
        image.image = #imageLiteral(resourceName: "Logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let userNameTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =  NSAttributedString(string: "Username",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIConstants.LightFont.withSize(17)])
        textField.font =  UIConstants.LightFont.withSize(17)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let firstNameTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =  NSAttributedString(string: "First name",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIConstants.LightFont.withSize(17)])
        textField.font =  UIConstants.LightFont.withSize(17)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let lastNameTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =  NSAttributedString(string: "Last name",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIConstants.LightFont.withSize(17)])
        textField.font =  UIConstants.LightFont.withSize(17)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =  NSAttributedString(string: "Password",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIConstants.LightFont.withSize(17)])
        textField.font = UIConstants.LightFont.withSize(17)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =  NSAttributedString(string: "Email",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIConstants.LightFont.withSize(17)])
        textField.font = UIConstants.LightFont.withSize(17)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let phoneTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =  NSAttributedString(string: "Phone",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIConstants.LightFont.withSize(17)])
        textField.font = UIConstants.LightFont.withSize(17)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.keyboardType = .phonePad
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    lazy var registerButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = UIColor.white
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIConstants.LightFont.withSize(17)
        button.backgroundColor = UIConstants.AppColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var facebookLoginButton : FBSDKLoginButton = {
        let fbButton = FBSDKLoginButton()
        //fbButton.addTarget(self, action: #selector(FBLoginButtonClicked), for: .touchUpInside)
        fbButton.translatesAutoresizingMaskIntoConstraints = false
        return fbButton
    }()
  
}

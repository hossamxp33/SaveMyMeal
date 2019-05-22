//
//  LoginModel.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 5/12/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
class LoginModel {
    var success : Bool?
    var data :  [String:Any]?
    var message : String?
    private static var UserId_ : Int!
    internal static var UserId : Int!
    {
        get
        {
            if UserId_ != nil
            { return UserId_}
            let val = UserDefaults.standard.object(forKey: "UserId")
            if val == nil {return nil}
            return ( val as! Int)
        }
        set
        {
            UserId_ = newValue as Int?
            UserDefaults.standard.setValue(newValue, forKey: "UserId")
            UserDefaults.standard.synchronize();
        }
    }
    private static var UserToken_ : String!
    internal static var UserToken : String!
    {
        get
        {
            if UserToken_ != nil
            { return UserToken_}
            let val = UserDefaults.standard.object(forKey: "UserToken")
            if val == nil {return nil}
            return ( val as! String)
        }
        set
        {
            UserToken_ = newValue as String?
            UserDefaults.standard.setValue(newValue, forKey: "UserToken")
            UserDefaults.standard.synchronize();
        }
    }
    static var isLogged : Bool {
        get{
            return (UserToken != nil)
        }
    }
    init(response: [String:Any]) {
         success = response["success"] as? Bool
         data = response["data"] as? [String:Any]
        if success! {
            LoginModel.UserId = data?["id"] as? Int
            LoginModel.UserToken = data?["token"] as? String
        }else{
            message = data?["message"] as? String
             
        }
    }
}

//
//  NetworkConstants.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/24/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation

struct NetworkConstants {
    static var BaseURL = "http://savemymeal.codesroots.com/api"
    
    static var getCategories = "categories/getcategories.json"
    static var searchCity = "cities/searchbyword.json"
    static var getRestaurants = "restaurants/getrestaurants"
    static var getUserOrders = "orders/getuserorder/"
    static var getRestReviews = "restaurants/getrestaurantreviewapp/"
    static var getRestInfo = "restaurants/getrestaurantinfo/"
    static var getSocialLinks = "socialmedias/getsocialmedia.json"
    static var addReview = "reviews/addreview.json"
    static var editOrder = "orders/edit"
    static var login = "users/token.json"
    static var register = "users/add.json"
    static var addOrder = "orders/addorder.json"
    static var restAmount = "restaurants/edit"
    static var getProfile = "users/getuserprofile/"
    static var contactUs = "restaurants/contactus.json"
    static var getRestByCatID = "restaurants/getrestaurantsbycatid"
    static var facebookLogin = "users/facebooklogin.json"
    static var editProfile = "users/edit/"
    
    static var forgetPasslink = "http://savemymeal.codesroots.com/usermgmt/users/forgotPassword"
    static var termsAndConditionslink = "http://savemymeal.codesroots.com/users/termsandconditions"
    
}

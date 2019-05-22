//
//  CustomImageView.swift
//  ShopGate
//
//  Created by Hadeer Kamel on 4/8/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(_ urlString: String)  {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            
            DispatchQueue.main.async(execute: {
                
                if let imageToCache =  UIImage(data: data!) {
                    
                    if self.imageUrlString == urlString {
                        
                        self.image = imageToCache
                        imageCache.setObject(imageToCache, forKey: urlString as NSString)
                        
                    }
                    
                }
                
            })
            
        }).resume()
    }
    func loadImageUsingUrlStringToUIImage(_ urlString: String,completion: @escaping (UIImage) -> ())  {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            
            DispatchQueue.main.async(execute: {
                
                if let imageToCache =  UIImage(data: data!) {
                    
                    if self.imageUrlString == urlString {
                        
                        self.image = imageToCache
                        imageCache.setObject(imageToCache, forKey: urlString as NSString)
                        
                    }
                    completion(self.image!)
                }else{
                    
                    return
                }
                
            })
            
        }).resume()
    }
}

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
    var rounded: Bool = false
    override func layoutSubviews() {
        super.layoutSubviews()
        if rounded {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = UIBezierPath(ovalIn:
                CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height
            )).cgPath
            layer.mask = shapeLayer
        }
    }
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

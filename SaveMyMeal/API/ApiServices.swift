//
//  ApiServices.swift
//  Eyes
//
//  Created by MAC on 1/20/18.
//  Copyright © 2018 codesroots. All rights reserved.
//


import UIKit


class ApiService : NSObject {
    
    static let SharedInstance = ApiService()
    
    let baseUrl = NSString(format: NetworkConstants.BaseURL as NSString)
    let defaults = UserDefaults.standard
    
    
    func request(URL:String) -> NSMutableURLRequest {
        let request : NSMutableURLRequest = NSMutableURLRequest()
        print(self.defaults.string(forKey: "token"))
        request.url = NSURL(string: NSString(format: "%@", "\(baseUrl)/\(URL)") as String) as URL?
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if self.defaults.string(forKey: "token") != nil {
            request.addValue("Bearer \(self.defaults.string(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        }
        let defaults = UserDefaults.standard
        
        
        
        return request
    }
    func fetchFeedForUrl(URL:String,completion: @escaping (Data)->()) {
        URLSession.shared.dataTask(with:request(URL: URL) as URLRequest , completionHandler: { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
                else {
                    print("error: not a valid http response")
                    return
            }
            print(response)
            print(receivedData)
            DispatchQueue.main.async {
                 print(receivedData)
                completion(receivedData)
                
        }
            
        }) .resume()
    }
    
    
    
    func Login (URL:String,dataarr:[String:Any]?,completion:@escaping ([String:AnyObject])->()){
        //   guard let ratess = dataarr else { return }
        
        let parameters = dataarr as! Dictionary<String, Any>
        
        let configuration = URLSessionConfiguration .default
        let session = URLSession(configuration: configuration)
        
        
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = NSURL(string: NSString(format: "%@",  "\(baseUrl)/\(URL)") as String) as URL?
        request.httpMethod = "Post"
        request.timeoutInterval = 30
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if self.defaults.string(forKey: "token") != nil {
            request.addValue("Bearer \(self.defaults.string(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        }
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        URLSession.shared.dataTask(with:request as URLRequest , completionHandler: { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
                else {
                    print("error: not a valid http response")
                    return
            }
            print(receivedData)
            switch (httpResponse.statusCode)
            {
            case 201:
                do {
                    let getResponse = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments)
                    print(getResponse)
                    DispatchQueue.main.async (execute: {
                        completion(getResponse  as! [String : AnyObject])
                    })
                } catch let error as NSError {
                    print(error)
                }
            case 200:
                do {
                    let getResponse = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments)
                  
                    DispatchQueue.main.async (execute: {
                        completion(getResponse  as! [String : AnyObject])
                    })
                } catch let error as NSError {
                    print(error)
                }
            case 401:
                do {
                    let getResponse = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments)
                    print(getResponse)
                    DispatchQueue.main.async (execute: {
                        completion(getResponse  as! [String : AnyObject])
                    })
                } catch let error as NSError {
                    print(error)
                }
                break
            case 422:
                do {
                    let getResponse = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments)
                    print(getResponse)
                    DispatchQueue.main.async (execute: {
                        completion(getResponse  as! [String : AnyObject])
                    })
                } catch let error as NSError {
                    print(error)
                }
            case 500:
                do {
                    let getResponse = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments)
                    print(getResponse)
                    DispatchQueue.main.async (execute: {
                        completion(getResponse  as! [String : AnyObject])
                    })
                } catch let error as NSError {
                    print(error)
                }
                break
                
            default:
                print("wallet GET request got response \(httpResponse.statusCode)")
            }
        }) .resume()
    }
    /////////////
    
    
    
    func LoginWithSwift (URL:String,dataarr:[String:Any]?,completion:@escaping (Data)->()){
        //   guard let ratess = dataarr else { return }
        
        let parameters = dataarr as! Dictionary<String, Any>
        
        let configuration = URLSessionConfiguration .default
        let session = URLSession(configuration: configuration)
        
        
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = NSURL(string: NSString(format: "%@",  "\(baseUrl)/\(URL)") as String) as URL?
        request.httpMethod = "Post"
        request.timeoutInterval = 30
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if self.defaults.string(forKey: "token") != nil {
            request.addValue("Bearer \(self.defaults.string(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        }
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        URLSession.shared.dataTask(with:request as URLRequest , completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async (execute: {
                completion(data!)
            })
            
        }) .resume()
    }
    
    
    
    
    
    /////////// post ary Of object
    func Post (URL:String,dataarr:[String:String]?,completion:@escaping ([String:AnyObject])->()){
        //   guard let ratess = dataarr else { return }
        
        let parameters = dataarr as! [String:String]
        
        let configuration = URLSessionConfiguration .default
        let session = URLSession(configuration: configuration)
        
        
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = NSURL(string: NSString(format: "%@",  "\(baseUrl)/\(URL)") as String) as URL?
        request.httpMethod = "Post"
        request.timeoutInterval = 30
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if self.defaults.string(forKey: "token") != nil {
            request.addValue("Bearer \(self.defaults.string(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        }
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        URLSession.shared.dataTask(with:request as URLRequest , completionHandler: { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
                else {
                    print("error: not a valid http response")
                    return
            }
            print(httpResponse)
            switch (httpResponse.statusCode)
            {
            case 201:
                do {
                    let getResponse = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments)
                    print(getResponse)
                    DispatchQueue.main.async (execute: {
                        completion(getResponse  as! [String : AnyObject])
                    })
                } catch let error as NSError {
                    print(error)
                }
            case 200:
                do {
                    let getResponse = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments)
                    print(getResponse)
                    DispatchQueue.main.async (execute: {
                        completion(getResponse  as! [String : AnyObject])
                    })
                } catch let error as NSError {
                    print(error)
                }
            case 401:
                do {
                    let getResponse = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments)
                    print(getResponse)
                    DispatchQueue.main.async (execute: {
                        completion(getResponse  as! [String : AnyObject])
                    })
                } catch let error as NSError {
                    print(error)
                }
                break
            case 422:
                do {
                    let getResponse = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments)
                    print(getResponse)
                    DispatchQueue.main.async (execute: {
                        completion(getResponse  as! [String : AnyObject])
                    })
                } catch let error as NSError {
                    print(error)
                }
            case 500:
                do {
                    let getResponse = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments)
                    print(getResponse)
                    DispatchQueue.main.async (execute: {
                        completion(getResponse  as! [String : AnyObject])
                    })
                } catch let error as NSError {
                    print(error)
                }
                break
                
            default:
                print("wallet GET request got response \(httpResponse.statusCode)")
            }
        }) .resume()
        
    }
    
    
    
   
}



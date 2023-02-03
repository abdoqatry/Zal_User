//
//  Router.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import Foundation

enum Router {
    
    case login(username:String,password:String,token:String)
    case citieslist
    case areas(city_id:String)
    case register(phone:String,name:String,email:String,password:String,password_confirmation:String,lat:String,lng:String,address:String)
    
    private var path: String {
        var path: String
        
        switch self {
            
        case.login:
            path = "api/login"
        case.citieslist:
            path = "provider/cities"
        case.areas:
            path = "provider/areas"
        case.register:
            path = "api/register"
            
        }
        return path
    }
    
    private var queryItems: [URLQueryItem]{
        
        var queryItems =  [URLQueryItem]()
        switch self {
        case.areas(let city_id):
            queryItems = [
            URLQueryItem(name: "city_id", value: city_id)
            ]
        default:
            queryItems = []
        }
        return queryItems
    }
    
    internal var parameter: [String: Any]?{
        
        var param = [String : Any]()
        switch self {
        case.login(let username,let password,let token):
            param = ["email" : username,
                     "password" : password,
//                     "device_token" : token,
//                     "device_type" : "ios",
                     
            ]
        case.register(let phone,let name,let email,let password,let password_confirmation,let lat,let lng,let address):
            param = [
                "phone" : phone,
                "name" : name,
                "email" : email,
                "password" : password,
                "password_confirmation" : password_confirmation,
                "lat" : lat,
                "lng" : lng,
                "address" : address
            ]
            
        default:
            return nil
        }
        print(param)
        return param
        
    }
    
    internal var requestURL: URL {
        var urlComponents = URLComponents(string:"https://zal.develobug.com/")
        if self.queryItems.count > 0 {
            urlComponents?.queryItems = self.queryItems
        }
        urlComponents?.path.append(contentsOf: self.path)
        let finalURL = urlComponents?.url!
        print("url is \(String(describing: finalURL))")
        return finalURL!
    }

}

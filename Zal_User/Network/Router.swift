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
    case forget_password(email:String)
    case check_forget_code(phone:String,code:String)
    case resend_forget_code(phone:String,type:String)
    case reset_password(phone:String,code:String,password:String,password_confirmation:String)
    case verify(phone:String,code:String)
    case resend_verify_code(phone:String,type:String)
    case sliders
    case home
    case profile
    case Editeprofile(name:String,phone:String,email:String)
    case update_password(old_password:String,password:String,password_confirmation:String)
    case orders(status:String)
    case near(lat:String,lng:String)
    
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
        case.forget_password:
            path = "api/forget_password"
        case.check_forget_code:
            path = "api/check_forget_code"
        case.resend_forget_code:
            path = "api/resend_forget_code"
        case.reset_password:
            path = "api/reset_password"
        case.verify:
            path = "api/verify"
        case.resend_verify_code:
            path = "api/resend_verify_code"
        case.sliders:
            path = "api/sliders"
        case.home:
            path = "api/home"
        case.profile:
            path = "api/profile"
        case.Editeprofile:
            path = "api/profile"
        case.update_password:
            path = "api/update_password"
        case.orders:
            path = "api/orders"
        case.near:
            path = "api/near"
            
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
        case.orders(let status):
            queryItems = [
            URLQueryItem(name: "status", value: status)
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
        case.forget_password(let email):
            param = [
                "email" : email
            ]
        case.check_forget_code(let phone,let code):
            param = [
                "phone" : phone,
                "code" : code
            ]
        case.resend_forget_code(let phone,let type):
            param = [
                "phone" : phone,
                "type" : type
            ]
        case.reset_password(let phone,let code,let password,let password_confirmation):
            param = [
                "phone" : phone,
                "code" : code,
                "password" : password,
                "password_confirmation" : password_confirmation
            ]
        case.verify(let phone,let code):
            param = [
                "phone" : phone,
                "code" : code
            ]
        case.resend_verify_code(let phone,let type):
            param = [
                "phone" : phone,
                "type" : type
            ]
        case.Editeprofile(let name,let phone,let email):
            param = [
                "name" : name,
                "phone" : phone,
            ]
        case.update_password(let old_password,let password,let password_confirmation):
            param = [
                "old_password" : old_password,
                "password" : password,
                "password_confirmation" : password_confirmation
            ]
        case.near(let lat,let lng):
            param = [
                "lat" : lat,
                "lng" : lng
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

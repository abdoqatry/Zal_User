//
//  HttpHeader.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//


import Alamofire
import UIKit

struct Headers {
    
    private static let testToken = ""
    
    static var unAuthenticatedHeader: HTTPHeaders {
       
        get {
            let lang = Bundle.currentAppleLanguage()
            return [
                "Accept" : "application/json",
                "Accept-Language" :  lang,
                "content-type" : "application/json",
            ]
        }
    }
    
    static var authenticatedHeader: HTTPHeaders {
        get {
            print("token is Bearer \(AuthService.instance.authToken  ?? "nil")")
            let lang = Bundle.currentAppleLanguage()
           
            return [
                "Accept" : "application/json",
                "Authorization" : "Bearer \(AuthService.instance.authToken  ?? "")",
                "content-type" : "application/json",
                "Accept-Language" : lang,
            ]
        }
    }
    
    
}


enum HeaderType {
    case authenticated, unAuthenticated
}



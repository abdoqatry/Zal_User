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
    case home(lat:String,lng:String,keyword:String)
    case profile
    case Editeprofile(name:String,phone:String,email:String)
    case update_password(old_password:String,password:String,password_confirmation:String)
    case orders(status:String)
    case near(lat:String,lng:String,keyword:String)
    case ordersDetails(id:String)
    case get_provider(id:String)
    case product_categories
    case get_products(catId:String,providerId:String,keyword:String)
    case product_rates(id:String)
    case get_product(id:String)
    case toggle_fav(id:String)
    case addresses
    case deleteaddresses(id:Int)
    case addAddress(name:String,name_en:String,desc:String,lat:String,lng:String,location:String)
    case editAddress(name:String,name_en:String,desc:String,lat:String,lng:String,location:String,id:Int)
    case fav_products
    case cancel_order(id:String)
    case store_cart(id:String,quantity:String)
    case cart
    case cartincrement(id:String)
    case cartdecrement(id:String)
    case cartcoupon(id:String)
    case checkoutOrders(address_id:String,pay_type:String,date:String)
    case chat
    case chatsgetMessages(page:String,id:String)
    case SendMessage(order_id:String,msg:String,msg_type:String)
    case search(lat:String,lng:String,keyword:String)
    case about
    case terms
    case service_orders(desc:String,day:String,time:String)
    case contact_info
    case contact(phone: String, email: String, message: String)
    
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
        case.ordersDetails(let id):
            path = "api/orders/\(id)"
        case.get_provider(let id):
            path = "api/get_provider/\(id)"
        case.product_categories:
            path = "api/product_categories"
        case.get_products(let catId,let providerId ,let keyword):
            path = "api/get_products/\(catId)/\(providerId)"
        case.product_rates(let id):
            path = "api/product_rates/\(id)"
        case.get_product(let id):
            path = "api/get_product/\(id)"
        case.toggle_fav(let id):
            path = "api/toggle_fav/\(id)"
        case.addresses :
            path = "api/addresses"
        case.deleteaddresses(let id):
            path = "api/addresses/\(id)"
        case.addAddress:
            path = "api/addresses"
        case.editAddress(_,_,_,_,_,_,let id):
            path = "api/addresses/\(id)"
        case.fav_products:
            path = "api/fav_products"
        case.cancel_order(let id):
            path = "api/cancel_order/\(id)"
        case.store_cart:
            path = "api/cart"
        case.cart:
            path = "api/cart"
        case.cartincrement(let id):
            path = "api/cart/increment/\(id)"
        case.cartdecrement(let id):
            path = "api/cart/decrement/\(id)"
        case.cartcoupon(let id):
            path = "api/cart/coupon/\(id)"
        case.checkoutOrders:
            path = "api/orders"
        case.chat:
            path = "api/chat"
        case.chatsgetMessages(let page,let id):
            path = "api/chat/\(id)"
        case.SendMessage:
            path = "api/chat"
        case.search:
            path = "api/search"
        case.about:
            path = "api/about_app"
        case.terms :
            path = "api/terms"
        case.service_orders:
            path = "api/service_orders"
        case.contact_info:
            path = "api/contact_info"
        case.contact:
            path = "provider/contact"
            
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
        case.get_products( _, _,let keyword):
            queryItems = [
            URLQueryItem(name: "keyword", value: keyword)
            ]
        case.orders(let status):
            queryItems = [
            URLQueryItem(name: "status", value: status)
            ]
        case.near(let lat,let lng,let keyword):
            queryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lng", value: lng),
            URLQueryItem(name: "keyword", value: keyword),
            ]
        case.search(let lat,let lng,let keyword):
            queryItems = [
                URLQueryItem(name: "lat", value: lat),
                URLQueryItem(name: "lng", value: lng),
                URLQueryItem(name: "keyword", value: keyword),
            ]
        case.home(let lat,let lng,let keyword):
            queryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lng", value: lng),
            URLQueryItem(name: "keyword", value: keyword),
            ]
        case.SendMessage(let order_id,let msg,let msg_type):
            queryItems = [
            URLQueryItem(name: "order_id", value: order_id),
            URLQueryItem(name: "msg", value: msg),
            URLQueryItem(name: "msg_type", value: msg_type),
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
                "email" : phone,
                "code" : code
            ]
        case.resend_forget_code(let phone,let type):
            param = [
                "email" : phone,
                "type" : type
            ]
        case.reset_password(let phone,let code,let password,let password_confirmation):
            param = [
                "email" : phone,
                "code" : code,
                "password" : password,
                "password_confirmation" : password_confirmation
            ]
        case.verify(let phone,let code):
            param = [
                "email" : phone,
                "code" : code
            ]
        case.resend_verify_code(let phone,let type):
            param = [
                "email" : phone,
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
//        case.near(let lat,let lng):
//            param = [
//                "lat" : lat,
//                "lng" : lng
//            ]
        case.addAddress(let name,let name_en,let desc,let lat,let lng,let location):
            param = [
                "name" : name,
                "name_en" : name_en,
                "desc" : desc,
                "lat" : lat,
                "lng" : lng,
                "location" : location
            ]
        case.editAddress(let name,let name_en,let desc,let lat,let lng,let location,let id):
            param = [
                "name" : name,
                "name_en" : name_en,
                "desc" : desc,
                "lat" : lat,
                "lng" : lng,
                "location" : location,
                "_method" : "PUT"
            ]
        case.store_cart(let id,let quantity):
            param = [
                "product_id" : id,
                "quantity" : quantity
            ]
        case.checkoutOrders(let address_id,let pay_type,let date):
            param = [
                "address_id" : address_id,
                "pay_type" : pay_type,
                "date" : date
            ]
        case.service_orders(let desc,let day,let time):
            param = [
                "desc" : desc,
                "day" : day,
                "time" : time
            ]
        case.contact(let phone,let email,let message):
            param = [
                "phone" : phone,
                "email" : email,
                "message" : message
            ]
            
        default:
            return nil
        }
        print(param)
        return param
        
    }
    
    internal var requestURL: URL {
        
        // https://zal.develobug.com/
        var urlComponents = URLComponents(string:"https://api.elzal.com/")
        if self.queryItems.count > 0 {
            urlComponents?.queryItems = self.queryItems
        }
        urlComponents?.path.append(contentsOf: self.path)
        let finalURL = urlComponents?.url!
        print("url is \(String(describing: finalURL))")
        return finalURL!
    }

}

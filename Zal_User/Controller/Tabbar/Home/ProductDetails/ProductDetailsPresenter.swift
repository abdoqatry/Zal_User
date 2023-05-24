//
//  ProductDetailsPresenter.swift
//  Zal_User
//
//  Created by Admin on 02/03/2023.
//

import Foundation

protocol ProductDetailsProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func Errormassage(msg:String)
    
    func setData(coverImage:[Image],name:String,price:String,description:String)
    
    func addToCart(msg:String)
  
}

class ProductDetailsPresenter {
    
    let vc: ProductDetailsProtocol
    
    init(_ controller: ProductDetailsProtocol) {
        vc = controller
    }
    
    func getProduct(id:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(ProductDetailsModel.self, Requst: .get_product(id: id), method: .get, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                let cover = Data?.data?.images ?? []
                let name = Data?.data?.name ?? ""
                let des = Data?.data?.description ?? ""
                var price = ""
                if Data?.data?.hasOffer == true{
                    price = Data?.data?.priceOffer ?? ""
                }else{
                    price = Data?.data?.price ?? ""
                }
                self?.vc.setData(coverImage: cover, name: name, price: price,description: des)
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func makeFavorite(id:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(CategoryModel.self, Requst: .toggle_fav(id: id), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.getProduct(id:id)
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func storeCart(id:String,quantity:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(CartModel.self, Requst: .store_cart(id: id, quantity: quantity), method: .post, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.vc.addToCart(msg: Data?.message ?? "")
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
}

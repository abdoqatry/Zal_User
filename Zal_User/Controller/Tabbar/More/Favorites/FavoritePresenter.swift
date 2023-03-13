//
//  FavoritePresenter.swift
//  Zal_User
//
//  Created by Admin on 12/03/2023.
//

import Foundation

protocol FavoriteProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func errormassage(msg:String)
    
    func dataReload()
  
}

protocol FavoriteCellView {
    func Data(name:String,Image:String,price:String,rate:Double,id:Int,is_liked:Bool)
   }

class FavoritePresenter {
    
    let vc: FavoriteProtocol
    
    init(_ controller: FavoriteProtocol) {
        vc = controller
    }
    
    var productsList : [FavoriteDatum] = []
    
    func getProducts(){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(FavoritesModel.self, Requst: .fav_products, method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.productsList = Data?.data ?? []
                self?.vc.dataReload()
            }else{
                self?.vc.errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func makeFavorite(index:Int){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        let id = String(productsList[index].id ?? 0)
        NetworkManager.shared.getData(CategoryModel.self, Requst: .toggle_fav(id: id), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.getProducts()
            }else{
                self?.vc.errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func GetProductsCount () -> Int{
        return  productsList.count
        }
    
    func configureProducts(cell: FavoriteCellView, index: Int) {
        let data = productsList[index]
        let name = data.name ?? ""
        let price = data.price ?? ""
        let rate = data.rate ?? 0.0
        let id = data.id ?? 0
        var Image = ""
        let liked = data.isLiked ?? false
        if data.images?.count != 0 {
            Image = data.images?.first?.image ?? ""
        }

        cell.Data(name: name, Image: Image, price: price, rate: rate, id: id, is_liked: liked)

        }
    
}

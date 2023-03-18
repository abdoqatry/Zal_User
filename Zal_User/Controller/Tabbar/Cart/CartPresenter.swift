//
//  CartPresenter.swift
//  Zal_User
//
//  Created by Admin on 18/03/2023.
//

import Foundation

protocol CartProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func errormassage(msg:String)
    
    func dataReload()
    
    func countTabel(count:Int)
    
    func setData(itemNum:String,amount:String,discountPer:String,deleveryFees:String,totalAmount:String,vat:String)
    
}

protocol CartProductsCellView {
    func Data(name:String,Image:String,price:String,countity:Int,desc:String)
   }

class CartPresenter {
    
    let vc: CartProtocol
    
    init(_ controller: CartProtocol) {
        vc = controller
    }
    
    var productList : [ProductElement] = []
    
    func getCart(){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(CartModel.self, Requst: .cart, method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.productList = Data?.data?.products ?? []
                let count = self?.productList.count ?? 0
                self?.vc.countTabel(count: count)
                self?.vc.dataReload()
               
                let amount = String(Data?.data?.productsTotal ?? 0)
                let discountper = String(Data?.data?.discountAmount ?? 0)
                let delevery = String(Data?.data?.delivery ?? 0)
                let total = String(Data?.data?.total ?? 0)
                let vat = String(Data?.data?.vat ?? 0.0)
                
                self?.vc.setData(itemNum: String(count), amount: amount, discountPer: discountper, deleveryFees: delevery, totalAmount: total,vat:vat)
            }else{
                self?.vc.errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func increamentCart(index:Int){
        let id = productList[index].id ?? ""
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(CartModel.self, Requst: .cartincrement(id: id), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.productList = Data?.data?.products ?? []
                let count = self?.productList.count ?? 0
                self?.vc.countTabel(count: count)
                self?.vc.dataReload()
        
            }else{
                self?.vc.errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func decreamentCart(index:Int){
        let id = productList[index].id ?? ""
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(CartModel.self, Requst: .cartdecrement(id: id), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.productList = Data?.data?.products ?? []
                let count = self?.productList.count ?? 0
                self?.vc.countTabel(count: count)
                self?.vc.dataReload()
        
            }else{
                self?.vc.errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func deleteCart(){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(CartModel.self, Requst: .cart, method: .delete, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.productList = Data?.data?.products ?? []
                let count = self?.productList.count ?? 0
                self?.vc.countTabel(count: count)
                self?.vc.dataReload()
               
                let amount = String(Data?.data?.productsTotal ?? 0)
                let discountper = String(Data?.data?.discountAmount ?? 0)
                let delevery = String(Data?.data?.delivery ?? 0)
                let total = String(Data?.data?.total ?? 0)
                let vat = String(Data?.data?.vat ?? 0.0)
                
                self?.vc.setData(itemNum: String(count), amount: amount, discountPer: discountper, deleveryFees: delevery, totalAmount: total,vat:vat)
            }else{
                self?.vc.errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    
    
    func GetCartCount () -> Int{
        return  productList.count
        }
    
    func configureType(cell: CartProductsCellView, index: Int) {
        let data = productList[index]
        let name = data.product?.name ?? ""
        let Image = data.product?.image ?? ""
        let price = data.product?.price ?? ""
        let desc = data.product?.description ?? ""
        let quantity = data.quantity ?? 0
       

        cell.Data(name: name, Image: Image, price: price, countity: quantity, desc: desc)
       
        }
    
}

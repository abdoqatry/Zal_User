//
//  OrderDetailsPresenter.swift
//  Zal_User
//
//  Created by Admin on 26/06/2023.
//

import Foundation

protocol OrderDetailsProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func Errormassage(msg:String)
    
    func getData(num:String,address:String,paymentType:String,price:Double,discount:Double,tax:Double,delivery:Double,total:Double)
    
    func navigationBack()
}

class OrderDetailsPresenter {
    
    let vc: OrderDetailsProtocol
    
    init(_ controller: OrderDetailsProtocol) {
        vc = controller
    }
    
    func getOrderDetails(id:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(OrdersDtailsModel.self, Requst: .ordersDetails(id: id), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                let num = Data?.data?.orderNum ?? ""
                let address = Data?.data?.provider?.address ?? ""
                let paymentType = Data?.data?.payType ?? ""
                let price = Data?.data?.productsTotal ?? 0.0
                let discount = Data?.data?.discountAmount ?? 0.0
                let tax = Data?.data?.vat ?? 0.0
                let delivery = Data?.data?.delivery ?? 0.0
                let total = Data?.data?.total ?? 0.0
                
                self?.vc.getData(num: num, address: address, paymentType: paymentType, price: price, discount: discount, tax: tax, delivery: delivery, total: total)
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
}

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
    
    func getData(time:String,location:String,productPrice:String,discount:String,paymenttype:String,delivery:String,total:String,status : String,vat:String,creatTime:String,appAmount:Double,providerAmount:Double,lat:String,lng:String,ispaided:Bool,shopname:String,shopImage:String,rate:Double,tax:Double)
    
    func navigationBack()
    
    func reloadTabel()
}

protocol OrderDetailsCellView {
    func Data(image:String,name:String,desc:String,quanty:String,price:Double)
   }

class OrderDetailsPresenter {
    
    let vc: OrderDetailsProtocol
    
    init(_ controller: OrderDetailsProtocol) {
        vc = controller
    }
    
    var OrderList : [ProductElement] = []
    
    func getOrderDetails(id:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(OrdersDtailsModel.self, Requst: .ordersDetails(id: id), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                let time = Data?.data?.date ?? ""
                let creatTime = Data?.data?.createdAt ?? ""
                let location = Data?.data?.address?.location ?? ""
                let productPrice = String(Data?.data?.productsTotal ?? 0)
                let discount = String(Data?.data?.discountAmount ?? 0)
                let paymenttype = Data?.data?.payType ?? ""
                let delivery = String(Data?.data?.delivery ?? 0)
                let total = String(Data?.data?.total ?? 0)
                let status = Data?.data?.status ?? ""
                let vat = String(Data?.data?.vat ?? 0)
                let appPercent = Data?.data?.appAmount ?? 0
                let providerAmount = Data?.data?.providerAmount ?? 0
                let lat = Data?.data?.address?.lat ?? ""
                let lan = Data?.data?.address?.lng ?? ""
                let paid = Data?.data?.is_paid ?? false
                let shopname = Data?.data?.provider?.name ?? ""
                let shopImage = Data?.data?.provider?.image ?? ""
                let rate = Data?.data?.provider?.rate ?? 0
                let tax = Data?.data?.tax ?? 0.0
                self?.vc.getData(time: time, location: location, productPrice: productPrice, discount: discount, paymenttype: paymenttype, delivery: delivery, total: total, status: status, vat: vat, creatTime: creatTime,appAmount:appPercent,providerAmount:providerAmount,lat:lat,lng:lan,ispaided:paid,shopname:shopname,shopImage:shopImage,rate:rate,tax: tax)
                
                self?.OrderList = Data?.data?.products ?? []
                self?.vc.reloadTabel()
                
//                self?.vc.getData(num: num, address: address, paymentType: paymentType, price: price, discount: discount, tax: tax, delivery: delivery, total: total)
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func GettransCount () -> Int{
        return  OrderList.count
        }
    
    func configureType(cell: OrderDetailsCellView, index: Int) {
           let data = OrderList[index]
        
        let image = data.product?.image ?? ""
        let name = data.product?.name ?? ""
        let des = data.product?.description ?? ""
        let quanty = String(data.quantity ?? 0)
        let price = data.price ?? 0
         
        cell.Data(image: image, name: name, desc: des, quanty: quanty, price: price)
       
        }
}

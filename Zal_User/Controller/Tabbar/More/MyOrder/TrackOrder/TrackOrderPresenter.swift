//
//  TrackOrderPresenter.swift
//  Zal_User
//
//  Created by Admin on 20/02/2023.
//

import Foundation

protocol TrackOrderProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func Errormassage(msg:String)
    
    func getData(status:String,isPaid:Bool)
    
    func navigationBack()
    
    func sendData(products:[ProductElement])
}


class TrackPresenter {
    
    let vc: TrackOrderProtocol
    
    init(_ controller: TrackOrderProtocol) {
        vc = controller
    }
    
    func getOrderDetails(id:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(OrdersDtailsModel.self, Requst: .ordersDetails(id: id), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.vc.getData(status: Data?.data?.status ?? "",isPaid:Data?.data?.is_paid ?? false)
                self?.vc.sendData(products: Data?.data?.products ?? [])
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func CancelOrder(id:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(OrdersDtailsModel.self, Requst: .cancel_order(id: id), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.vc.navigationBack()
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    
}

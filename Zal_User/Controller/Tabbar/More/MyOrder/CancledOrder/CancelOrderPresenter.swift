//
//  CancelOrderPresenter.swift
//  Zal_User
//
//  Created by Admin on 15/02/2023.
//

import Foundation


protocol CancelOrderProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func Errormassage(msg:String)
    
    func selectIndex(id : String)
    
    func realoadData()
}

protocol CancelOrderCellView {
    func Data(number:String,status:String,total:String)
   }

class CancelPresenter {
    
    let vc: CancelOrderProtocol
    
    init(_ controller: CancelOrderProtocol) {
        vc = controller
    }
    
    var OrderList : [CurrentOrderDatum] = []
    
    func getCancelOrder(){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(CurrentOrderModel.self, Requst: .orders(status: "cancel"), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                
                self?.OrderList = Data?.data ?? []
                self?.vc.realoadData()
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func GettransCount () -> Int{
        return  OrderList.count
        }
    
    func configureType(cell: CancelOrderCellView, index: Int) {
           let data = OrderList[index]
        
        let number = data.orderNum ?? ""
        let status = data.status ?? ""
        let id = data.id ?? ""
        let total = String(data.total ?? 0.0)
         
        cell.Data(number: number, status: status, total: total)
       
        }
    
}

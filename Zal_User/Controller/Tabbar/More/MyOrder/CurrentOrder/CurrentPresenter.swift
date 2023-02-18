//
//  CurrentPresenter.swift
//  Zal_User
//
//  Created by Admin on 14/02/2023.
//

import Foundation

protocol CurrentOrderProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func Errormassage(msg:String)
    
    func selectIndex(id : String)
    
    func realoadData()
}

protocol CurrentOrderCellView {
    func Data(number:String,status:String,total:String)
   }

class CurrentPresenter {
    
    let vc: CurrentOrderProtocol
    
    init(_ controller: CurrentOrderProtocol) {
        vc = controller
    }
    
    var OrderList : [CurrentOrderDatum] = []
    
    func getCurrentOrder(){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(CurrentOrderModel.self, Requst: .orders(status: "in_progress"), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
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
    
    func configureType(cell: CurrentOrderCellView, index: Int) {
           let data = OrderList[index]
        
        let number = data.orderNum ?? ""
        let status = data.status ?? ""
        let id = data.id ?? ""
        let total = String(data.total ?? 0.0)
         
        cell.Data(number: number, status: status, total: total)
       
        }
    
    
    
}

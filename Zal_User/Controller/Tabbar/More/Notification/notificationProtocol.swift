//
//  notificationProtocol.swift
//  Zal_User
//
//  Created by Admin on 11/11/2023.
//

import Foundation


protocol notificationProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func Errormassage(msg:String)
    
    func realoadData()
    
    func notifictionCount(count:Int)
    
    func selectcell(orderId:String,type:String,title:String,body:String)
}


protocol notificationCellView {
    func Data(name:String,image:String)
   }

class NotificationPresenter {
    
    let vc: notificationProtocol

    init(_ controller: notificationProtocol) {
            vc = controller
    }

    var notificationList : [notifictionDatum] = []
    
    func getnotification(){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(NotificationModel.self, Requst: .notifications, method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                
                self?.notificationList = Data?.data ?? []
                self?.vc.notifictionCount(count: Data?.data?.count ?? 0)
                self?.vc.realoadData()
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func GettransCount () -> Int{
        return  notificationList.count
        }
    
    func configureType(cell: notificationCellView, index: Int) {
           let data = notificationList[index]
        
        let name = data.title ?? ""
        let imge = data.image ?? ""
         
        cell.Data(name: name, image: imge)
       
        }
    
    func didselect(index:Int){
        let data = notificationList[index]
//        if data.notifyType == 1 {
        vc.selectcell(orderId: data.orderID ?? "", type: data.notifyType ?? "",title:data.title ?? "",body:data.body ?? "")
//        }
    }
    
}

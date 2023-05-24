//
//  messagePresenter.swift
//  Zal_User
//
//  Created by Admin on 02/04/2023.
//

import Foundation

protocol MessageListProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func Errormassage(msg:String)
    
    func realoadData()
    
    func selectCell(id:String,orderId:String)
}

protocol MessageCellView {
    func Data(image:String,name:String,time:String,desc:String)
   }


class MessageListPresenter {
    
    let vc: MessageListProtocol

    init(_ controller: MessageListProtocol) {
            vc = controller
    }

    var MessageList : [listMessageDatum] = []

    func getMessageList(){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(MessageListModel.self, Requst: .chat, method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                
                self?.MessageList = Data?.data ?? []
                self?.vc.realoadData()
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func GettransCount () -> Int{
        return  MessageList.count
        }
    
    func configureType(cell: MessageCellView, index: Int) {
           let data = MessageList[index]
        
        let img = data.user?.image ?? ""
        let name = data.user?.name ?? ""
        let time =  convertDateFormater(data.createdAt ?? "")
        let message = data.lastMsg ?? ""
         
        cell.Data(image: img, name: name, time: time, desc: message)
       
        }

    func didselectCell(index: Int){
        let id = MessageList[index].id ?? ""
        let orderId = MessageList[index].order?.id ?? ""
        
        self.vc.selectCell(id: id, orderId: orderId)
    }

    func convertDateFormater(_ date: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss "
            let date = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "HH:mm"
            return  dateFormatter.string(from: date!)

        }

}

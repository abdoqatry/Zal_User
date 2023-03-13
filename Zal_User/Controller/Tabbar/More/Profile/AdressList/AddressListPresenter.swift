//
//  AddressListPresenter.swift
//  Zal_User
//
//  Created by Admin on 11/03/2023.
//

import Foundation

protocol AdressListProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func Errormassage(msg:String)
    
    func selectIndex(id : Int,name:String,description:String,location:String,lat:String,lon:String)
    
    func realoadData()
}

protocol AddressListCellView {
    func Data(title:String,description:String,id:String)
   }


class AddressListPresenter {
    
    let vc: AdressListProtocol
    
    init(_ controller: AdressListProtocol) {
        vc = controller
    }
    
    var AddressList : [AdressDatum] = []
    
    func getAddress(){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(AddressListModel.self, Requst: .addresses, method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                
                self?.AddressList = Data?.data ?? []
                self?.vc.realoadData()
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func delteAddress(index:Int){
        let id = AddressList[index].id ?? 0
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(AddressListModel.self, Requst: .deleteaddresses(id: id), method: .delete, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.getAddress()
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func editAddress(index:Int){
        let data = AddressList[index]
        let id = data.id ?? 0
        let name = data.name ?? ""
        let des = data.desc ?? ""
        let location = data.location ?? ""
        let lat = data.lat ?? ""
        let lon = data.lng ?? ""
        
        self.vc.selectIndex(id: id, name: name, description: des, location: location, lat: lat, lon: lon)
        
    }
    
    func GetCount () -> Int{
        return  AddressList.count
        }
    
    func configureType(cell: AddressListCellView, index: Int) {
           let data = AddressList[index]
        
        let title = data.name ?? ""
        let desc = data.desc ?? ""
        let id = String(data.id ?? 0)
         
        cell.Data(title: title, description: desc, id: id)
       
        }
    
}

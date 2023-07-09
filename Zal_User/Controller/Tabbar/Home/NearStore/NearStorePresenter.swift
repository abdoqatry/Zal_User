//
//  NearStorePresenter.swift
//  Zal_User
//
//  Created by Admin on 15/02/2023.
//

import Foundation

protocol NearStoreProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func Errormassage(msg:String)
    
    func dataReload()
    
    func dataCount(count:Int)
    
    func selectIndex(id : String)
  
}

protocol NearCellView {
    func Data(name:String,ProfileImage:String,address:String,CoverImage:String,rate:Double,distance:Double,category:String)
   }

class NearStorePresenter {
    
    let vc: NearStoreProtocol
    
    init(_ controller: NearStoreProtocol) {
        vc = controller
    }
    
    var neartoreList : [nearModel] = []
    
    func getHome(lat:String,lan:String,search:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(NearStoreModel.self, Requst: .near(lat: lat, lng: lan,keyword:search), method: .get, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.neartoreList = Data?.data ?? []
                self?.vc.dataCount(count: Data?.data?.count ?? 0 )
                self?.vc.dataReload()
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func searchHome(lat:String,lan:String,search:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(NearStoreModel.self, Requst: .search(lat: lat, lng: lan,keyword:search), method: .get, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.neartoreList = Data?.data ?? []
                self?.vc.dataCount(count: Data?.data?.count ?? 0 )
                self?.vc.dataReload()
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func GetSpecialCount () -> Int{
        return  neartoreList.count
        }
    
    func configureNear(cell: NearCellView, index: Int) {
        let data = neartoreList[index]
        
        let name = data.name ?? ""
        let profileImage = data.image ?? ""
        let address = data.address ?? ""
        let coverimage = data.coverImage ?? ""
        let rate = data.rate ?? 0
        let distance = data.distance ?? 0.0
        let category = data.mainCategory?.name ?? ""
         
        cell.Data(name: name, ProfileImage: profileImage, address: address, CoverImage: coverimage, rate: rate, distance: distance,category: category)
       
        }
    
    func selecteCell(index:Int){
        let id = String(neartoreList[index].id ?? 0)
        self.vc.selectIndex(id: id)
    }
    
}

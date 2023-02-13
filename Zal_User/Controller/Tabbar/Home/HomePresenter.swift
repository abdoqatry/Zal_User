//
//  HomePresenter.swift
//  Zal_User
//
//  Created by Admin on 08/02/2023.
//

import Foundation

protocol HomeProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func Errormassage(msg:String)
    
    func setSlidertData(slider:[sliderModel])
    
    func dataReload()
  
}

protocol SpcialStoreCellView {
    func Data(name:String,ProfileImage:String,address:String,coverImage:String,rate:Int)
   }

protocol NearStoreCellView {
    func Data(name:String,ProfileImage:String,address:String,CoverImage:String,rate:Int,distance:Double)
   }


class HomePresenter {
    
    let vc: HomeProtocol
    
    init(_ controller: HomeProtocol) {
        vc = controller
    }
    
    var spcialstoreList : [Provider] = []
    var nearStoreList : [Provider] = []
    
    func getSlider(){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(SliderModel.self, Requst: .sliders, method: .get, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                let slider = Data?.data ?? []
                self?.vc.setSlidertData(slider: slider)
                
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    func getHome(){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(HomeModel.self, Requst: .home, method: .get, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                self?.spcialstoreList = Data?.data?.mostRatedProviders ?? []
                self?.nearStoreList = Data?.data?.nearestProviders ?? []
                
                self?.vc.dataReload()
            }else{
                self?.vc.Errormassage(msg: Data?.data?.message ?? "")
            }
            
        }
    }
    
    func GetSpecialCount () -> Int{
        return  spcialstoreList.count
        }
    
    func configureType(cell: SpcialStoreCellView, index: Int) {
        let data = spcialstoreList[index]
        
        let name = data.name ?? ""
        let profileImage = data.image ?? ""
        let address = data.address ?? ""
        let coverimage = data.coverImage ?? ""
        let rate = data.rate ?? 0
         
        cell.Data(name: name, ProfileImage: profileImage, address: address, coverImage: coverimage, rate: rate)
       
        }
    
    func GetnearCount () -> Int{
        return  nearStoreList.count
        }
    
    func configureNear(cell: NearStoreCellView, index: Int) {
        let data = nearStoreList[index]
        
        let name = data.name ?? ""
        let profileImage = data.image ?? ""
        let address = data.address ?? ""
        let coverimage = data.coverImage ?? ""
        let rate = data.rate ?? 0
        let distance = data.distance ?? 0.0
         
        cell.Data(name: name, ProfileImage: profileImage, address: address, CoverImage: coverimage, rate: rate, distance: distance)
       
        }
    
}

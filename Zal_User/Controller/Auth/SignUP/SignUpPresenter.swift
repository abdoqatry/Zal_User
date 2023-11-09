//
//  SignUpPresenter.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import Foundation

protocol SignUpProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func Errormassage(msg:String)

    func navigate()
}


class SignUPPresenter {
    
    let vc: SignUpProtocol

    init(_ controller: SignUpProtocol) {
            vc = controller
            

    }
    
    func getLoged(name: String, phone: String, email: String, password: String, password_confirmation: String, city_id: Int, area_id: Int, lat: String, lng: String, address: String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        let token = AuthService.instance.fcmToken ?? ""
        NetworkManager.shared.getData(UserModel.self, Requst: .register(phone: phone, name: name, email: email, password: password, password_confirmation: password_confirmation, lat: lat, lng: lng, address: address, token: token), method: .post, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                guard let token = Data else { return }
                AuthService.instance.SetTokenDefaults(user: token)
               
                self?.vc.navigate()
                
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }



}


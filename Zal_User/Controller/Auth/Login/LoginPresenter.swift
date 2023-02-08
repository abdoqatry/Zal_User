//
//  LoginPresenter.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import Foundation


protocol LoginProtocol {
    
    func openIndicator(title: String, description: String)
    
    func closeIndicator()
    
    func openingVerivecation(phone:String)
    
    func Errormassage(msg:String)

    func navigateLogin()
}


class LoginPresenter {
    
    let vc: LoginProtocol

    init(_ controller: LoginProtocol) {
            vc = controller
            

    }
    
    func getLoged(phone:String,pass:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        let token = AuthService.instance.fcmToken ?? ""
        NetworkManager.shared.getData(UserModel.self, Requst: .login(username: phone, password: pass, token: token), method: .post, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 200 {
                guard let token = Data else { return }
                AuthService.instance.SetTokenDefaults(user: token)
//                if AuthService.instance.Verifyat == false {
//                    self?.vc.openingVerivecation(phone: "")
//                }else{
                self?.vc.navigateLogin()
//                }
            }else{
                self?.vc.Errormassage(msg: Data?.message ?? "")
            }
            
        }
    }
    
    
    
}


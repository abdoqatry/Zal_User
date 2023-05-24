//
//  CheckOutPresenter.swift
//  Zal_User
//
//  Created by Admin on 30/03/2023.


import Foundation

import Foundation

protocol CeckoutProtocol {

    func openIndicator(title: String, description: String)

    func closeIndicator()

    func errormassage(msg:String)

    func dataReload()

    func navigatetoorder(id:String,num:String)

}

class CechoutPresenter {

    let vc: CeckoutProtocol

    init(_ controller: CeckoutProtocol) {
        vc = controller
    }

    func addCart(addressId:String,pay:String,date:String){
        vc.openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(CheckoutModel.self, Requst: .checkoutOrders(address_id: addressId, pay_type: pay, date: date), method: .post, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.vc.closeIndicator()
            if Code == 201 {
                self?.vc.navigatetoorder(id: Data?.data?.id ?? "", num: Data?.data?.orderNum ?? "")
            }else{
                self?.vc.errormassage(msg: Data?.message ?? "")
            }

        }
    }

}

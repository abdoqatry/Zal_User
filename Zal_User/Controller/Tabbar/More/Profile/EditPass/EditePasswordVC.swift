//
//  EditePasswordVC.swift
//  Zal_User
//
//  Created by Admin on 13/02/2023.
//

import UIKit

class EditePasswordVC: UIViewController {

    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var newPassTF: UITextField!
    @IBOutlet weak var oldPassTF: UITextField!
    @IBOutlet weak var confirmBT: UIButton!
    @IBOutlet var itemsView: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    
    func setView(){
        confirmBT.layer.cornerRadius = 18
        title = "Edit Password"
        for i in itemsView{
            i.layer.cornerRadius = 22
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.layer.borderWidth = 0.5
        }
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        
        guard let oldPass = oldPassTF.text , !oldPass.isEmpty, oldPass.count > 5 else{
            showAlert(title: "Enter a password of at least 6 characters".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        guard let newPass = newPassTF.text , !newPass.isEmpty, newPass.count > 5 else{
            showAlert(title: "Enter a new password of at least 6 characters".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        
        guard let confirmPass = confirmPassTF.text , !confirmPass.isEmpty, confirmPass == newPass else{
            showAlert(title: "password doesn't match".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(ProfileModel.self, Requst: .update_password(old_password: oldPass, password: newPass, password_confirmation: confirmPass), method: .post, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                self?.showAlert(title: "Password Updated".localize, messages: nil, message: nil, selfDismissing: true)
                DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                // Put your code which should be executed with a delay here
                self?.navigationController?.popViewController(animated: true)
           }
        }
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }
    
}

//
//  NewPasswordVC.swift
//  Zal_User
//
//  Created by Admin on 05/02/2023.
//

import UIKit

class NewPasswordVC: UIViewController {

    @IBOutlet weak var RoundedView: UIView!
    @IBOutlet var passwordView: [UIView]!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var saveBT: UIButton!
    
    var email = ""
    var code = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
    
    func setView(){
        RoundedView.layer.cornerRadius = 25
        saveBT.layer.cornerRadius = 22
        for i in passwordView{
            i.layer.cornerRadius = 22
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.layer.borderWidth = 0.5
        }
        
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        guard let pass = passwordTF.text , !pass.isEmpty, pass.count > 5 else{
            showAlert(title: "Enter a password of at least 6 characters".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        guard let confirmPass = confirmPassTF.text , pass == confirmPass else{
            showAlert(title: "password dosn't match".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        
        resetPassword(email: email, code: code, password: pass, password_confirmation: confirmPass)
    }
    
    func resetPassword(email: String, code: String, password: String, password_confirmation: String){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(ForgetPassModel.self, Requst: .reset_password(phone: email, code: code, password: password, password_confirmation: password_confirmation), method: .post, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
        guard let window =  UIApplication.shared.keyWindow else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC")  as! LoginVC
        let Login = UINavigationController(rootViewController: rootViewController)
            window.rootViewController = Login
                
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }
    
    
}

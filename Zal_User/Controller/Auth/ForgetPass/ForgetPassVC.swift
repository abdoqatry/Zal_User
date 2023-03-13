//
//  ForgetPassVC.swift
//  Zal_User
//
//  Created by Admin on 04/02/2023.
//

import UIKit

class ForgetPassVC: UIViewController {

    @IBOutlet weak var RoundedView: UIView!
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var SendCodeBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setview()
    }
    
    func Setview(){
        RoundedView.layer.cornerRadius = 25
        EmailView.layer.cornerRadius = 22
        EmailView.layer.borderColor = UIColor.lightGray.cgColor
        EmailView.layer.borderWidth = 0.5
        SendCodeBT.layer.cornerRadius = 22
    }
    
    @IBAction func SendCodeAction(_ sender: UIButton) {
        guard  let mail = EmailTF.text , mail.isEmail  else{
                showAlert(title:   "Enter valid mail".localize, messages: nil, message: nil, selfDismissing: true)
                return  }
        forgetPassword(email: mail)
    }
    
    func forgetPassword(email:String){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(ForgetPassModel.self, Requst: .forget_password(email: email), method: .post, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ForgetPassCodeVC")  as! ForgetPassCodeVC
                vc.email = email
                self?.navigationController?.pushViewController(vc, animated: true)
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }
    

}

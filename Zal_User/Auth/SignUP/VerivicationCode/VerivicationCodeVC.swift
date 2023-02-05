//
//  VerivicationCodeVC.swift
//  Zal_User
//
//  Created by Admin on 05/02/2023.
//

import UIKit

class VerivicationCodeVC: UIViewController {

    @IBOutlet var CodeView: [UIView]!
    @IBOutlet weak var textFeild1: UITextField!
    @IBOutlet weak var textFeild2: UITextField!
    @IBOutlet weak var textFeild3: UITextField!
    @IBOutlet weak var textFeild4: UITextField!
    @IBOutlet weak var textFeild5: UITextField!
    @IBOutlet weak var textFeild6: UITextField!
    @IBOutlet weak var RoundedView: UIView!
    @IBOutlet weak var sendCodeBT: UIButton!
    
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setTextFieldDelegat()
        
    }
    
    func setView(){
        for i in CodeView {
            i.layer.cornerRadius = 25
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.layer.borderWidth = 0.5
        }
        RoundedView.layer.cornerRadius = 25
        sendCodeBT.layer.cornerRadius = 22
    }
    
    @IBAction func sendCodeButton(_ sender: UIButton) {
        let lang = Bundle.currentAppleLanguage()
        var activationCode = ""
        if lang == "en" {
      activationCode =   "\(textFeild1.text!)\(textFeild2.text!)\(textFeild3.text!)\(textFeild4.text!)\(textFeild5.text!)\(textFeild6.text!)"
        }else {
        activationCode =   "\(textFeild6.text!)\(textFeild5.text!)\(textFeild4.text!)\(textFeild3.text!)\(textFeild2.text!)\(textFeild1.text!)"
        }
        
        forgetPasswordCode(email: email, code: activationCode)
//        let vc = Bundle.main.loadNibNamed("NewPasswordVC", owner: nil, options: nil)![0] as! NewPasswordVC
//        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func forgetPasswordCode(email:String,code:String){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(CheckPassModel.self, Requst: .verify(phone: email, code: code), method: .post, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "NewPasswordVC")  as! NewPasswordVC
//                vc.email = email
//                vc.code = code
//                self?.navigationController?.pushViewController(vc, animated: true)
//
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }
    
    @IBAction func ResendButton(_ sender: UIButton) {
        checkForgetPassword(email: email, type: "reset")
    }
    
    func checkForgetPassword(email:String,type:String){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(ForgetPassModel.self, Requst: .resend_verify_code(phone: email, type: type), method: .post, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                self?.showAlert(title: "code has been sent to your mail".localize, messages: nil, message: nil, selfDismissing: true)
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }

}



extension VerivicationCodeVC: UITextFieldDelegate{
    //MARK: UITextField Delegates
    @objc func editTextField(textField : UITextField){
        let text = textField.text
        let pre = Bundle.currentAppleLanguage()
//        let lang = UserDefaults.standard.value(forKey: "AppleLanguages") as? String
        textFeild1.textAlignment = .center
        textFeild2.textAlignment = .center
        textFeild3.textAlignment = .center
        textFeild4.textAlignment = .center
        textFeild5.textAlignment = .center
        textFeild6.textAlignment = .center
        if pre == "en"{
        if (text?.utf16.count)! >= 1 {
            textField.text = String(textField.text!.last!)
            switch textField{
            case textFeild1:
                textFeild2.text = ""
                textFeild2.becomeFirstResponder()
                
            case textFeild2:
                textFeild3.text = ""
                textFeild3.becomeFirstResponder()
                
            case textFeild3:
                textFeild4.text = ""
                textFeild4.becomeFirstResponder()
                
            case textFeild4:
                textFeild5.text = ""
                textFeild5.becomeFirstResponder()
                
            case textFeild5:
                textFeild6.text = ""
                textFeild6.becomeFirstResponder()
                
            case textFeild6:
                textFeild6.resignFirstResponder()
            default:
                break
            }
        }
        }else{
            if (text?.utf16.count)! >= 1 {
            textField.text = String(textField.text!.last!)
            switch textField{
            case textFeild6:
                textFeild5.text = ""
                textFeild5.becomeFirstResponder()
                
            case textFeild5:
                textFeild4.text = ""
                textFeild4.becomeFirstResponder()
                
            case textFeild4:
                textFeild3.text = ""
                textFeild3.becomeFirstResponder()
                
            case textFeild3:
                textFeild2.text = ""
                textFeild2.becomeFirstResponder()
                
            case textFeild2:
                textFeild1.text = ""
                textFeild1.becomeFirstResponder()
                
            case textFeild1:
            textFeild1.resignFirstResponder()
            default:
                break
                  }
              }
            
        }
        
    }
    
    func setTextFieldDelegat(){
        textFeild1.delegate = self
        textFeild2.delegate = self
        textFeild3.delegate = self
        textFeild4.delegate = self
        textFeild5.delegate = self
        textFeild6.delegate = self
        
        textFeild1.addTarget(self, action: #selector(editTextField), for: UIControl.Event.editingChanged)
        textFeild2.addTarget(self, action: #selector(editTextField), for: UIControl.Event.editingChanged)
        textFeild3.addTarget(self, action: #selector(editTextField), for: UIControl.Event.editingChanged)
        textFeild4.addTarget(self, action: #selector(editTextField), for: UIControl.Event.editingChanged)
        textFeild5.addTarget(self, action: #selector(editTextField), for: UIControl.Event.editingChanged)
        textFeild6.addTarget(self, action: #selector(editTextField), for: UIControl.Event.editingChanged)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        
        let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        switch textField {
        case textFeild1:
            textFeild2.becomeFirstResponder()

        case textFeild2:
            textFeild3.becomeFirstResponder()
            
        case textFeild3:
            textFeild4.becomeFirstResponder()

        case textFeild4:
            textFeild5.becomeFirstResponder()
            
        case textFeild5:
            textFeild6.becomeFirstResponder()
            
        case textFeild6: break
            
        default:
            return true
        }

        return true
    }
    
}


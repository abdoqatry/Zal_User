//
//  LoginVC.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import UIKit

class LoginVC: UIViewController,LoginProtocol {
    func openingVerivecation(phone: String) {
//        let vc = Bundle.main.loadNibNamed("HoldePageVC", owner: nil, options: nil)![0] as! HoldePageVC
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func navigateLogin() {
        present(viewController: HomeTabbarVC())
    }
    

    @IBOutlet weak var ForgetPassBT: UIButton!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var PasswordView: UIView!
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var RoundedView: UIView!
    @IBOutlet weak var SignInBT: UIButton!
    
    var presenter : LoginPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(self)
        SetView()
        setupNavigationBar()
    }

    func SetView(){
        PasswordTF.delegate = self
        RoundedView.layer.cornerRadius = 25
        EmailView.layer.cornerRadius = 22
        PasswordView.layer.cornerRadius = 22
        EmailView.layer.borderColor = UIColor.lightGray.cgColor
        EmailView.layer.borderWidth = 0.5
        PasswordView.layer.borderColor = UIColor.lightGray.cgColor
        PasswordView.layer.borderWidth = 0.5
        SignInBT.layer.cornerRadius = 22
        linedBt(Button: ForgetPassBT, tittle:"Forget Password ?".localize, color: colorWithHexString(hexString: "#8B004C"))
    }
    
    @IBAction func SigninAction(_ sender: UIButton) {
        guard  let mail = EmailTF.text , !mail.isEmpty , mail.isEmail  else{
            showAlert(title:  "Enter valid mail".localize, messages: nil, message: nil, selfDismissing: true)
                return  }
        
        guard let pass = PasswordTF.text , !pass.isEmpty, pass.count > 5 else{
            showAlert(title: "Enter a password of at least 6 characters".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        presenter?.getLoged(phone: mail, pass: pass)
    }
    
    @IBAction func RegisterationButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUP")  as! SignUP
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func ForgetPassButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ForgetPassVC")  as! ForgetPassVC

        navigationController?.pushViewController(vc, animated: true)
    }

}


extension LoginVC : UITextFieldDelegate{

private func textFieldDidBeginEditing(textField: UITextField) {
    textField.text = ""
}

// handel validation in search filters
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

    if textField == EmailTF {
        let newLength: Int = textField.text!.count + string.count - range.length
        let numberOnly = NSCharacterSet.init(charactersIn: "0123456789").inverted
        let strValid = string.rangeOfCharacter(from: numberOnly) == nil
        return (strValid && (newLength <= 9))

    }else{
    let newLength: Int = textField.text!.count + string.count - range.length
    let numberOnly = NSCharacterSet.init(charactersIn: "0123456789aqwertyuiopsdfghjklzxcvb!@#$%^`?؟..ّ±`~٫&*():;`][\'/?§}|,/._-=~<>+{}nm£€اِبتثجحخدذرزمسشصضطظع•¥غفقكلنهويئىلاةQWERTYUIOPASDFGHJKLZXCVBSßNM'\" ").inverted
    let strValid = string.rangeOfCharacter(from: numberOnly) == nil
           return (strValid && (newLength <= 40))
    }
    
    }
}

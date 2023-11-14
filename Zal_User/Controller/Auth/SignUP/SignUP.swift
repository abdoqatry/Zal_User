//
//  SignUP.swift
//  Zal_User
//
//  Created by Admin on 03/02/2023.
//

import UIKit

class SignUP: UIViewController,SignUpProtocol {
    
    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func navigate() {
        
    }
    

    @IBOutlet weak var RoundedView: UIView!
    @IBOutlet weak var nextBT: UIButton!
    @IBOutlet var itemsView: [UIView]!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var areaView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var TermsBT: UIButton!
    @IBOutlet weak var pliceBT: UIButton!
    
    var police = 0
    var date2 = ""
    var cityId = 0
    var areaId = 0
    var catId = 0
    var lat = ""
    var lon = ""
    
    var presenter : SignUPPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignUPPresenter(self)
        setView()
        
    }
    
    func setView(){
        phoneTF.delegate = self
        pliceBT.setTitle("Agree to the terms and conditions".localize, for: .normal)
        cityLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(city)))
        addressLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getAddress)))
        areaLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(area)))
       
//        navigationController?.isNavigationBarHidden = true
        RoundedView.layer.cornerRadius = 25
        nextBT.layer.cornerRadius = 22
        areaView.layer.cornerRadius = 22
        areaView.layer.borderColor = UIColor.lightGray.cgColor
        areaView.layer.borderWidth = 0.5
        for i in itemsView{
            i.layer.cornerRadius = 22
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.layer.borderWidth = 0.5
        }
        
    }
    
    @IBAction func termsAndConditionBtnAction(_ sender: Any) {
        let VC = Bundle.main.loadNibNamed("TermsVc", owner: nil, options: nil)![0] as! TermsVc

        navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func TermsAction(_ sender: UIButton) {
        if police == 0 {
            police = 1
            TermsBT.setImage(UIImage(named: "check"), for: .normal)
        }else{
            police = 0
            TermsBT.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    
    @objc func city(){
         let modalViewController = CityPositionVC()
        self.view.endEditing(true)
        
         modalViewController.delegetCity = self
         presentPop(viewController: modalViewController)
     }
    
    @objc func area(){
         let vc = AreaPositionVC()
        self.view.endEditing(true)
        vc.id = cityId
        vc.delegetArea = self
         presentPop(viewController: vc)
     }
    
    @objc func getAddress(){
        let VC = Bundle.main.loadNibNamed("MapPageVC", owner: nil, options: nil)![0] as! MapPageVC
                VC.deleget = self
        
        self.navigationController?.pushViewController(VC, animated: true)
    }

    @IBAction func nextButtonAction(_ sender: UIButton) {
        guard police != 0   else{
            showAlert(title:  "you have accept app police".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        guard  let name = userNameTF.text , !name.isEmpty   else{
            showAlert(title:  "Enter user name".localize, messages: nil, message: nil, selfDismissing: true)
                return  }
        guard let phone = phoneTF.text , !phone.isEmpty, phone.count == 9  else{
            showAlert(title:  "Enter Phone Number".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        guard  let mail = mailTF.text , !mail.isEmpty , mail.isEmail  else{
            showAlert(title:  "Enter valid mail".localize, messages: nil, message: nil, selfDismissing: true)
                return  }
        guard let pass = passwordTF.text , !pass.isEmpty, pass.count > 5 else{
            showAlert(title: "Enter a password of at least 6 characters".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        
//        guard catId != 0  else{
//            showAlert(title:  "please choose category".localize, messages: nil, message: nil, selfDismissing: true)
//        return  }
        guard cityId != 0  else{
            showAlert(title:  "please choose city".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        guard areaId != 0  else{
            showAlert(title:  "please choose area".localize, messages: nil, message: nil, selfDismissing: true)
        return  }

        
        guard lat != "" || lon != "" else{
            showAlert(title:  "please choose Address".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        guard  let address = addressLabel.text , !address.isEmpty   else{
                showAlert(title:  "please choose Address".localize, messages: nil, message: nil, selfDismissing: true)
                return  }
        presenter?.getLoged(name: name, phone: phone, email: mail, password: pass, password_confirmation: pass, city_id: cityId, area_id: areaId, lat: lat, lng: lon, address: address)
        
    }
    
    
    
}


extension SignUP : CItyprotocole{
    func passCity(value: String, Id: Int, code: String) {
        if Id != -1 && Id != 0 {
            areaView.isHidden = false
         cityId = Id
        cityLabel.text = value
        cityLabel.textColor = .black
        }
    }
    
}

extension SignUP : Areaprotocole{
    func passCity2(value: String, Id: Int, code: String) {
        if Id != -1 && Id != 0 {
           
         areaId = Id
        areaLabel.text = value
        areaLabel.textColor = .black
        }
    }
    
}

extension SignUP : Mapprotocole{
    func MapDate(Lat: String, Lon: String, address: String) {
        self.lat = Lat
        self.lon = Lon
        self.addressLabel.text  = address
    }
}

extension SignUP : UITextFieldDelegate{

private func textFieldDidBeginEditing(textField: UITextField) {
    textField.text = ""
}

// handel validation in search filters
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

    if textField == phoneTF {
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



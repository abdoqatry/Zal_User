//
//  TermsVc.swift
//  Zal_User
//
//  Created by Admin on 11/07/2023.
//

import UIKit
import WebKit

class TermsVc: UIViewController {

    @IBOutlet weak var LogoImage: UIImageView!
    @IBOutlet weak var termwebview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Terms and condition".localize
//        let image = UIImage(named: "Group 23843")?.withRenderingMode(.alwaysTemplate)
//        LogoImage.image = image
//        LogoImage.tintColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
        getData()
        
    }
    

    func getData(){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
      NetworkManager.shared.getData(AboutModel.self, Requst: .terms,method: .get, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
          self?.closeIndicator()
            if Code == 200 {
                  let lang = Bundle.currentAppleLanguage()
                self?.termwebview.loadHTMLString(Data?.data ?? "", baseURL: nil)
            }else{
                
              self?.showAlert(title: Constants.UNEXPECTED_ERROR, messages: nil, message: nil, selfDismissing: true)
            }
        }
        
    }

}

//
//  SettingVC.swift
//  Zal_User
//
//  Created by Admin on 09/07/2023.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var switcherNotification: UISwitch!
    @IBOutlet weak var notificationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView(){
        title = "Settings".localize
        languageView.layer.cornerRadius = 16
        languageView.layer.applySketchShadow()
        notificationView.layer.cornerRadius = 16
        notificationView.layer.applySketchShadow()
        languageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Langues)))
        
    }
    
    @objc func Langues(){
        let VC = Bundle.main.loadNibNamed("ChooseLangVC", owner: nil, options: nil)![0] as! ChooseLangVC
        VC.deleget = self
        presentPop(viewController: VC)
      
              
          }
    
    
    func chngeLangue(langue:String){
        
        let lang = Bundle.currentAppleLanguage()
                    
        if lang == langue {
                    return
                }
        
        Bundle.setAppleLAnguageTo(langue)

        // Update the language by swaping bundle
        Bundle.setLanguage(langue)
        guard let window =  UIApplication.shared.keyWindow else { return }
      
        if langue == "ar"  {
            
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            
            
        }else if langue == "en"{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight

            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
        
        }
        

        window.rootViewController = HomeTabbarVC()
            
  
    }
    

}


extension SettingVC : langProtocolo{
    func MerDate(value: String, Id: Int) {
           chngeLangue(langue: value)
       
    }
     
}

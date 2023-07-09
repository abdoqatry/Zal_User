//
//  ChooseLangVC.swift
//  Zal_User
//
//  Created by Admin on 09/07/2023.
//

import UIKit

protocol langProtocolo {
    func MerDate(value : String,Id :Int)
}

class ChooseLangVC: UIViewController {
    
    @IBOutlet weak var MainView: UIView!
    
    @IBOutlet weak var EngBT: UIButton!
    @IBOutlet weak var ARBT: UIButton!
    
    var deleget : langProtocolo?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        MainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.Diss)))
    }
    
    @objc func Diss(){
        dismiss(animated: true, completion: nil)
    }

    @IBAction func EngButton(_ sender: UIButton) {
        deleget?.MerDate(value: "en", Id: 0)
        dismiss(animated: true, completion: nil)
//        chngeLangue(langue: "en")

    }
    @IBAction func ARButton(_ sender: UIButton) {
//        chngeLangue(langue: "ar")
        deleget?.MerDate(value: "ar", Id: 0)
        dismiss(animated: true, completion: nil)

    }
    


}

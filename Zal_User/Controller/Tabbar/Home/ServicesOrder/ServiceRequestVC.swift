//
//  ServiceRequestVC.swift
//  Zal_User
//
//  Created by Admin on 02/10/2023.
//

import UIKit

class ServiceRequestVC: UIViewController,UITextViewDelegate {

    @IBOutlet var itemsView: [UIView]!
    @IBOutlet weak var MessageTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView(){
        MessageTV.delegate = self
        MessageTV.text = "Description of the required service".localize
        for i in itemsView{
            i.layer.cornerRadius = 22
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.layer.borderWidth = 0.5
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
     
        if textView.text == "Description of the required service" || textView.text == "وصف الخدمة المطلوبة" {
            textView.text = ""
            textView.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)

        }
        
    }


    func textViewDidEndEditing(_ textView: UITextView) {

            if textView.text.isEmpty {
                textView.text = "Description of the required service".localize
                textView.textColor = UIColor.gray
//            }


        }
       
    }
    
    
//    @objc func OpenTimefrom(){
//
//        let myView = Bundle.main.loadNibNamed("DateController", owner: nil, options: nil)![0] as! DateController
//                 myView.delegetDate = self
//        myView.mode = 2
//        myView.type = 1
//        presentPop(viewController: myView)
//        }

}

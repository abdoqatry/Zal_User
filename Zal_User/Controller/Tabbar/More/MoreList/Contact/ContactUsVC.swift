//
//  ContactUsVC.swift
//  Zal_User
//
//  Created by Admin on 07/11/2023.
//

import UIKit

class ContactUsVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var sendBT: UIButton!
    @IBOutlet weak var messageTV: UITextView!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var whatappImage: UIImageView!
    @IBOutlet weak var twitterImage: UIImageView!
    @IBOutlet weak var facebookImage: UIImageView!
    @IBOutlet weak var gmailImage: UIImageView!
    @IBOutlet weak var InstegramImage: UIImageView!
    @IBOutlet weak var snapChatImage: UIImageView!
    @IBOutlet weak var PhonNumTF: UITextField!
    @IBOutlet var itemView: [UIView]!
    
    
    let placeholderText = "Message".localize
    var phone = ""
    var mail = ""
    var instegram = ""
    var snapChat = ""
    var facebook = ""
    var twitter = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contact us".localize
        setView()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = .black
        }
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
    
    func setView(){
        for i in itemView{
            i.layer.cornerRadius = 20
            i.layer.borderWidth = 0.5
            i.layer.borderColor = UIColor.lightGray.cgColor
        }
        sendBT.layer.cornerRadius = 12
        messageTV.delegate = self
        gmailImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openMail)))
        InstegramImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openInstegram)))
        
    }
    
    func contactinfo(){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(ContactInfoModel.self, Requst: .contact_info, method: .get, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                self?.phone = Data?.data?.phone ?? ""
                self?.mail = Data?.data?.email ?? ""
                self?.instegram = Data?.data?.insta ?? ""
                self?.twitter = Data?.data?.twitter ?? ""
                self?.snapChat = Data?.data?.snapchat ?? ""
                self?.facebook = Data?.data?.facebook ?? ""
                
            }else{
//                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }
    
    
    @IBAction func sendButton(_ sender: UIButton) {
        
    }
    
    @objc func openMail(){
        if let url = URL(string: "mailto:\(mail)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
    @objc func openInstegram(){
        if let url = URL(string: self.instegram) {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
    func openWhatsApp(number : String){
        var fullMob = phone
            fullMob = fullMob.replacingOccurrences(of: " ", with: "")
            fullMob = fullMob.replacingOccurrences(of: "+", with: "")
            fullMob = fullMob.replacingOccurrences(of: "-", with: "")
            let urlWhats = "whatsapp://send?phone=\(fullMob)"
            
            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                if let whatsappURL = NSURL(string: urlString) {
                    if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                        UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: { (Bool) in
                        })
                    } else {
//                        AppTool.showAlertView(vc: self, titleString: "Error", messageString: "WhatsApp Not Found on your device")
                        // Handle a problem
                    }
                }
            }
        }
    
    
}

//
//  ContactUsVC.swift
//  Zal_User
//
//  Created by Admin on 07/11/2023.
//

import UIKit

class ContactUsVC: UIViewController {

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
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contact us".localize
        setView()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == placeholderText {
            textView.text = ""
        }
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
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
        
    }
    
    
    @IBAction func sendButton(_ sender: UIButton) {
        
    }
    
    
    
}

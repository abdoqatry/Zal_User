//
//  EditeProfileVC.swift
//  Zal_User
//
//  Created by Admin on 13/02/2023.
//

import UIKit

class EditeProfileVC: UIViewController {

    @IBOutlet weak var pgoneTF: UITextField!
    @IBOutlet weak var MailTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet var itemsView: [UIView]!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        getProfile()
    }
    
    func setView(){
        title = "Profile"
        profileView.layer.cornerRadius = 60
        profileImage.layer.cornerRadius = 60
        profileView.layer.applySketchShadow()
        for i in itemsView{
            i.layer.cornerRadius = 25
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.layer.borderWidth = 0.5
        }
        
    }
    
    func getProfile(){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(ProfileModel.self, Requst: .profile, method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                let profileUrl = URL(string: Data?.data?.image ?? "")
                self?.nameTF.text = Data?.data?.name ?? ""
                self?.MailTF.text = Data?.data?.email ?? ""
                self?.pgoneTF.text = Data?.data?.phone ?? ""
                self?.profileImage.kf.setImage(with: profileUrl)
                
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }

}

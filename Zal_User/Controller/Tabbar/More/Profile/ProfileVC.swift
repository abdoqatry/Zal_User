//
//  ProfileVC.swift
//  Zal_User
//
//  Created by Admin on 12/02/2023.
//

import UIKit

class ProfileVC: UIViewController {

    
    @IBOutlet weak var GreetingView: UIView!
    @IBOutlet weak var EditePassView: UIView!
    @IBOutlet weak var editeaddressView: UIView!
    @IBOutlet weak var EditeProfileView: UIView!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var ProfileView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProfile()
    }
    
    
    func setView(){
        title = "Profile"
        ProfileView.layer.cornerRadius = 60
        ProfileImage.layer.cornerRadius = 60
        ProfileImage.layer.applySketchShadow()
        EditeProfileView.layer.applySketchShadow()
        EditeProfileView.layer.cornerRadius = 12
        editeaddressView.layer.applySketchShadow()
        editeaddressView.layer.cornerRadius = 12
        EditePassView.layer.applySketchShadow()
        EditePassView.layer.cornerRadius = 12
        GreetingView.layer.applySketchShadow()
        GreetingView.layer.cornerRadius = 12
        EditeProfileView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editeProfileAction)))
        EditePassView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editePasswordAction)))
        editeaddressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editeAdreesAction)))
    }
    
    @objc func editeProfileAction(){
        let vc = Bundle.main.loadNibNamed("EditeProfileVC", owner: nil, options: nil)![0] as! EditeProfileVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func editeAdreesAction(){
        let vc = Bundle.main.loadNibNamed("ShowlistAdressVC", owner: nil, options: nil)![0] as! ShowlistAdressVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func editePasswordAction(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditePasswordVC")  as! EditePasswordVC
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getProfile(){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(ProfileModel.self, Requst: .profile, method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                let profileUrl = URL(string: Data?.data?.image ?? "")
               
                self?.ProfileImage.kf.setImage(with: profileUrl)
                
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }

}

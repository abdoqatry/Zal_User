//
//  AboutViewController.swift
//  Zal_User
//
//  Created by Admin on 11/07/2023.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var LogoImage: UIImageView!
    @IBOutlet weak var aboutLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About us".localize
//        let image = UIImage(named: "Group 23843")?.withRenderingMode(.alwaysTemplate)
//        LogoImage.image = image
//        LogoImage.tintColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
        getData()
        
    }
    

    func getData(){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
      NetworkManager.shared.getData(AboutModel.self, Requst: .about,method: .get, headerType: .unAuthenticated) {[weak self] (Massage, Data, Code) in
          self?.closeIndicator()
            if Code == 200 {
                self?.aboutLbl.text = Data?.data ?? ""
                self?.aboutLbl.setLineHeight(lineHeight: 7)
               
            }else{
                
              self?.showAlert(title: Constants.UNEXPECTED_ERROR, messages: nil, message: nil, selfDismissing: true)
            }
        }
        
    }
}


// MARK: - AboutModel
struct AboutModel: Codable {
    let data, mssage: String?
//    let status: Int?
}

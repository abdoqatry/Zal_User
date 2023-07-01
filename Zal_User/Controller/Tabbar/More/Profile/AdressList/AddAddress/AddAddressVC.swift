//
//  AddAddressVC.swift
//  Zal_User
//
//  Created by Admin on 11/03/2023.
//

import UIKit

class AddAddressVC: UIViewController {

    @IBOutlet var itemsView: [UIView]!
    @IBOutlet weak var saveBT: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    
    var lat = ""
    var lon = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    
    func setView(){
        title = "Add Address".localize
        for i in itemsView{
            i.layer.cornerRadius = 18
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.layer.borderWidth = 0.5
        }
        saveBT.layer.cornerRadius = 14
        addressLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getAddress)))
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        guard  let name = nameTF.text , !name.isEmpty   else{
            showAlert(title:  "Enter location name".localize, messages: nil, message: nil, selfDismissing: true)
                return  }
        guard  let des = descriptionTF.text , !des.isEmpty   else{
            showAlert(title:  "Enter location description".localize, messages: nil, message: nil, selfDismissing: true)
                return  }
        guard lat != "" || lon != "" else{
            showAlert(title:  "please choose Address".localize, messages: nil, message: nil, selfDismissing: true)
        return  }
        guard  let address = addressLabel.text , !address.isEmpty   else{
                showAlert(title:  "please choose Address".localize, messages: nil, message: nil, selfDismissing: true)
                return  }
        AddAddress(name: name, desc: des, location: address, lat: lat, lon: lon)
    }
    
    @objc func getAddress(){
        let VC = Bundle.main.loadNibNamed("MapPageVC", owner: nil, options: nil)![0] as! MapPageVC
                VC.deleget = self
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func AddAddress(name:String,desc:String,location:String,lat:String,lon:String){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(AddressModel.self, Requst: .addAddress(name: name, name_en: name, desc: desc, lat: lat, lng: lon, location: location), method: .post, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 201 {
                self?.navigationController?.popViewController(animated: true)
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }

}


extension AddAddressVC : Mapprotocole{
    func MapDate(Lat: String, Lon: String, address: String) {
        self.lat = Lat
        self.lon = Lon
        self.addressLabel.text  = address
    }
}

//
//  EditAddressVC.swift
//  Zal_User
//
//  Created by Admin on 12/03/2023.
//

import UIKit

class EditAddressVC: UIViewController {

    @IBOutlet var itemsView: [UIView]!
    @IBOutlet weak var saveBT: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    
    var lat = ""
    var lon = ""
    var id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView(){
        title = "Edit Address".localize
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
        EditAddress(name: name, desc: des, location: address, lat: lat, lon: lon,id:id)
    }
    
    @objc func getAddress(){
        let VC = Bundle.main.loadNibNamed("MapPageVC", owner: nil, options: nil)![0] as! MapPageVC
                VC.deleget = self
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func EditAddress(name:String,desc:String,location:String,lat:String,lon:String,id:Int){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(AddressModel.self, Requst: .editAddress(name: name, name_en: name, desc: desc, lat: lat, lng: lon, location: location, id: id), method: .post, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                self?.navigationController?.popViewController(animated: true)
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }
    

}

extension EditAddressVC : Mapprotocole{
    func MapDate(Lat: String, Lon: String, address: String) {
        self.lat = Lat
        self.lon = Lon
        self.addressLabel.text  = address
    }
}

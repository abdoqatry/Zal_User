//
//  ShowlistAdressVC.swift
//  Zal_User
//
//  Created by Admin on 11/03/2023.
//

import UIKit

class ShowlistAdressVC: UIViewController,AdressListProtocol {
    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func selectIndex(id : Int,name:String,description:String,location:String,lat:String,lon:String) {
        let vc = Bundle.main.loadNibNamed("EditAddressVC", owner: nil, options: nil)![0] as! EditAddressVC
        vc.id = id
        vc.nameTF.text = name
        vc.descriptionTF.text = description
        vc.addressLabel.text = location
        vc.lat = lat
        vc.lon = lon
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func realoadData() {
        adressTabelView.reloadData()
    }
    

    @IBOutlet weak var AddBT: UIButton!
    @IBOutlet weak var adressTabelView: UITableView!{
        didSet {
            adressTabelView.delegate = self
            adressTabelView.dataSource = self
            adressTabelView.registerCell(withCellType: AdressCell.self)
        }
    }
    
    var presenter : AddressListPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddressListPresenter(self)
        title = "Addresses".localize
        
        AddBT.layer.cornerRadius = 16
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getAddress()
    }
    
    @IBAction func AddButton(_ sender: UIButton) {
        let vc = Bundle.main.loadNibNamed("AddAddressVC", owner: nil, options: nil)![0] as! AddAddressVC
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension ShowlistAdressVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.GetCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AdressCell = adressTabelView.dequeueReusableCell(forIndexPath: indexPath)
        presenter?.configureType(cell: cell, index: indexPath.row)
        cell.selectionStyle = .none
        cell.deletefunction = {
            self.presenter?.delteAddress(index: indexPath.row)
        }
        cell.editfunction = {
            self.presenter?.editAddress(index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.selecteCell(index: indexPath.row)
    }
    
    
}


extension ShowlistAdressVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
}


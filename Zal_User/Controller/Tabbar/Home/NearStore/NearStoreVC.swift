//
//  NearStoreVC.swift
//  Zal_User
//
//  Created by Admin on 12/02/2023.
//

import UIKit

class NearStoreVC: UIViewController,NearStoreProtocol,UITextFieldDelegate {
    
    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func dataReload() {
        NearStoreTabelView.reloadData()
    }
    
    func dataCount(count:Int){
        if count != 0 {
            NearStoreTabelView.isHidden = false
            nodataLabel.isHidden = true
        }else{
            NearStoreTabelView.isHidden = true
            nodataLabel.isHidden = false
        }
    }
    
    func selectIndex(id : String){
        let vc = Bundle.main.loadNibNamed("StoreVC", owner: nil, options: nil)![0] as! StoreVC
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var nodataLabel: UILabel!
    @IBOutlet weak var NearStoreTabelView: UITableView!{
        didSet {
            NearStoreTabelView.delegate = self
            NearStoreTabelView.dataSource = self
            NearStoreTabelView.registerCell(withCellType: NearStoreTabelCell.self)
        }
    }
    
    @IBOutlet weak var SearchTF: UITextField!
    
    var search = ""
    
    
    var presenter : NearStorePresenter?
    var lastLat = ""
    var lastlon = ""  String(LocationManager.SharedInstans.getlongitude())
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NearStorePresenter(self)
        setlocation()
        SearchTF.delegate = self
        SearchTF.returnKeyType = UIReturnKeyType.search
        SearchTF.layer.cornerRadius = 15
        SearchTF.clipsToBounds = true
        
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getHome(lat: lastLat, lan: lastlon,search:search)
    }
    
    func setlocation(){
        let userdata = AuthService.instance
        if userdata.authToken == "" || userdata.authToken == nil {
            lastLat =  String(LocationManager.SharedInstans.getlatitude())
            lastlon =  String(LocationManager.SharedInstans.getlongitude())
        }else{
            lastLat = userdata.lattitude ?? ""
            lastlon = userdata.lantitude ?? ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search = SearchTF.text ?? ""
        presenter?.getHome(lat: lastLat, lan: lastlon,search:search)

        return true
    }
    

}



extension NearStoreVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.GetSpecialCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NearStoreTabelCell = NearStoreTabelView.dequeueReusableCell(forIndexPath: indexPath)
        presenter?.configureNear(cell: cell, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selecteCell(index: indexPath.row)
    }
    
}


extension NearStoreVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
        
    }
    
}

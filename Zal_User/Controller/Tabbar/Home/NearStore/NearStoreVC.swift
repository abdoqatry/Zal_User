//
//  NearStoreVC.swift
//  Zal_User
//
//  Created by Admin on 12/02/2023.
//

import UIKit

class NearStoreVC: UIViewController,NearStoreProtocol {
    
    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func dataReload() {
        NearStoreTabelView.reloadData()
    }
    
    @IBOutlet weak var NearStoreTabelView: UITableView!{
        didSet {
            NearStoreTabelView.delegate = self
            NearStoreTabelView.dataSource = self
            NearStoreTabelView.registerCell(withCellType: NearStoreTabelCell.self)
        }
    }
    
    
    var presenter : NearStorePresenter?
    var lastLat = String(LocationManager.SharedInstans.getlatitude())
    var lastlon = String(LocationManager.SharedInstans.getlongitude())
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NearStorePresenter(self)
        
        presenter?.getHome(lat: "31.254444422221", lan: "31.25557777777")
        
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
//        presenter.selectRecipeCell(index: indexPath.row, RecipeId: 1)
    }
    
}


extension NearStoreVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
        
    }
    
}

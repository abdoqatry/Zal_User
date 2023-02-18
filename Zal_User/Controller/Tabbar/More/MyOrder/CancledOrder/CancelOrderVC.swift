//
//  CancelOrderVC.swift
//  Zal_User
//
//  Created by Admin on 15/02/2023.
//

import UIKit

class CancelOrderVC: UIViewController,CancelOrderProtocol {
    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func realoadData() {
        canceltOrderTabelView.reloadData()
        if presenter?.GettransCount() != 0 {
            nodataLabel.isHidden = true
        }else{
            nodataLabel.isHidden = false
        }
    }
    
    func selectIndex(id: String) {
        
    }
    

    @IBOutlet weak var nodataLabel: UILabel!
    @IBOutlet weak var canceltOrderTabelView: UITableView!{
        didSet {
            canceltOrderTabelView.delegate = self
            canceltOrderTabelView.dataSource = self
            canceltOrderTabelView.registerCell(withCellType: CancelOrderCell.self)
        }
    }
    var presenter : CancelPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CancelPresenter(self)
        presenter?.getCancelOrder()
    }
    
    

}



extension CancelOrderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.GettransCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CancelOrderCell = canceltOrderTabelView.dequeueReusableCell(forIndexPath: indexPath)
        presenter?.configureType(cell: cell, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.selecteCell(index: indexPath.row)
    }
    
}


extension CancelOrderVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
        
    }
}

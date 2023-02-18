//
//  CurrentOrderVC.swift
//  Zal_User
//
//  Created by Admin on 13/02/2023.
//

import UIKit

class CurrentOrderVC: UIViewController,CurrentOrderProtocol {

    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func realoadData() {
        currentOrderTabelView.reloadData()
        if presenter?.GettransCount() != 0 {
            nodataLabel.isHidden = true
        }else{
            nodataLabel.isHidden = false
        }
    }
    
    func selectIndex(id : String){
//        let vc = Bundle.main.loadNibNamed("OrderDetailsVC", owner: nil, options: nil)![0] as! OrderDetailsVC
//        vc.id = id
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var nodataLabel: UILabel!
    @IBOutlet weak var currentOrderTabelView: UITableView!{
        didSet {
            currentOrderTabelView.delegate = self
            currentOrderTabelView.dataSource = self
            currentOrderTabelView.registerCell(withCellType: CurrentOrderCell.self)
        }
    }
    var presenter : CurrentPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CurrentPresenter(self)
        presenter?.getCurrentOrder()
    }

}



extension CurrentOrderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.GettransCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CurrentOrderCell = currentOrderTabelView.dequeueReusableCell(forIndexPath: indexPath)
        presenter?.configureType(cell: cell, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.selecteCell(index: indexPath.row)
    }
    
}


extension CurrentOrderVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
        
    }
}

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
    
    func selectIndex(id : String,num:String){
        let vc = Bundle.main.loadNibNamed("TrackOrderVC",owner: nil, options: nil)![0] as! TrackOrderVC
        vc.id = id
        vc.orderNumTF.text = num
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func selectorder(id:String){
        let vc = Bundle.main.loadNibNamed("OrderDetailsVC",owner: nil, options: nil)![0] as! OrderDetailsVC
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.openDelivery2), name: NSNotification.Name(rawValue: "OpenOrders"), object: nil)

    }
    
    @objc func openDelivery2(){
        let id = AuthService.instance.id ?? ""
        let num = AuthService.instance.orderNum ?? ""
        let vc = Bundle.main.loadNibNamed("TrackOrderVC",owner: nil, options: nil)![0] as! TrackOrderVC
        vc.id = id
        vc.orderNumTF.text = num
        self.navigationController?.pushViewController(vc, animated: true)
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
        cell.trackOrderafunction = {
            self.presenter?.selecteCell(index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.OpenCell(index: indexPath.row)
    }
    
}


extension CurrentOrderVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
        
    }
}

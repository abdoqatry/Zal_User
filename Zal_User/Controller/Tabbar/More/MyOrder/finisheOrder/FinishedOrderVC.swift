//
//  FinishedOrderVC.swift
//  Zal_User
//
//  Created by Admin on 14/02/2023.
//

import UIKit

class FinishedOrderVC: UIViewController,FinshOrderProtocol {
    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func realoadData() {
        finshOrderTabelView.reloadData()
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
    @IBOutlet weak var finshOrderTabelView: UITableView!{
        didSet {
            finshOrderTabelView.delegate = self
            finshOrderTabelView.dataSource = self
            finshOrderTabelView.registerCell(withCellType: FinishedOrderCell.self)
        }
    }
    var presenter : FinshPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FinshPresenter(self)
        presenter?.getFinshOrder()
        
    }
    
    

}


extension FinishedOrderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.GettransCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FinishedOrderCell = finshOrderTabelView.dequeueReusableCell(forIndexPath: indexPath)
        presenter?.configureType(cell: cell, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.selecteCell(index: indexPath.row)
    }
    
}


extension FinishedOrderVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
        
    }
}

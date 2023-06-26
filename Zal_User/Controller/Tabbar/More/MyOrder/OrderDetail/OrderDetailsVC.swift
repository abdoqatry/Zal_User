//
//  OrderDetailsVC.swift
//  Zal_User
//
//  Created by Admin on 26/06/2023.
//

import UIKit

class OrderDetailsVC: UIViewController {
    
    @IBOutlet weak var TabelHeight: NSLayoutConstraint!
    @IBOutlet weak var orderDetailTabel: UITableView!{
        didSet {
            orderDetailTabel.delegate = self
            orderDetailTabel.dataSource = self
            orderDetailTabel.registerCell(withCellType: OrderDetailsCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    

}



extension OrderDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderDetailsCell = orderDetailTabel.dequeueReusableCell(forIndexPath: indexPath)
//        presenter?.configureType(cell: cell, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.selectRecipeCell(index: indexPath.row, RecipeId: 1)
    }
    
}


extension OrderDetailsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
}

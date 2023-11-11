//
//  NotificationVC.swift
//  Zal_User
//
//  Created by Admin on 11/11/2023.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var NodataLabel: UILabel!
    @IBOutlet weak var NotificationTabelView: UITableView!{
        didSet {
            NotificationTabelView.delegate = self
            NotificationTabelView.dataSource = self
            NotificationTabelView.registerCell(withCellType: NotificationCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    

}


extension NotificationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.GettransCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationCell = NotificationTabelView.dequeueReusableCell(forIndexPath: indexPath)
        presenter?.configureType(cell: cell, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.selectRecipeCell(index: indexPath.row, RecipeId: 1)
        presenter?.didselect(index: indexPath.row)
    }
    
}


extension NotificationVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
        
    }
}


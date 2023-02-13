//
//  NearStoreVC.swift
//  Zal_User
//
//  Created by Admin on 12/02/2023.
//

import UIKit

class NearStoreVC: UIViewController {

    @IBOutlet weak var NearStoreTabelView: UITableView!{
        didSet {
            NearStoreTabelView.delegate = self
            NearStoreTabelView.dataSource = self
            NearStoreTabelView.registerCell(withCellType: NearStoreTabelCell.self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

}



extension NearStoreVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NearStoreTabelCell = NearStoreTabelView.dequeueReusableCell(forIndexPath: indexPath)
//        presenter?.configureType(cell: cell, index: indexPath.row)
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

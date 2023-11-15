//
//  EditOrderVC.swift
//  Zal_User
//
//  Created by Admin on 15/11/2023.
//

import UIKit

class EditOrderVC: UIViewController {

    @IBOutlet weak var editBT: UIButton!
    @IBOutlet weak var ProductTabelView: UITableView!{
        didSet {
            ProductTabelView.delegate = self
            ProductTabelView.dataSource = self
            ProductTabelView.registerCell(withCellType: CartProductCell.self)
        }
    }
    
    var products : [ProductElement]? {
        didSet{
            ProductTabelView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func EditButtonAction(_ sender: UIButton) {
        
    }
    
    
    

}



extension EditOrderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartProductCell = ProductTabelView.dequeueReusableCell(forIndexPath: indexPath)
        cell.deleteBT.isHidden = true
//        presenter?.configureType(cell: cell, index: indexPath.row)
        
//        cell.incrementProducte = {
//            self.presenter?.increamentCart(index: indexPath.row)
//        }
//        cell.decrementProducte = {
//            self.presenter?.decreamentCart(index: indexPath.row)
//        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.selectRecipeCell(index: indexPath.row, RecipeId: 1)
//        let vc = Bundle.main.loadNibNamed("ProductDetailsVC", owner: nil, options: nil)![0] as! ProductDetailsVC
//        vc.id = "1"
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension EditOrderVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    
   
}

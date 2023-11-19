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
            ProductTabelView.registerCell(withCellType: EditCartCell.self)
        }
    }
    
    var products : [ProductElement]? {
        didSet{
            ProductTabelView.reloadData()
        }
    }
    
    var orderID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Order".localize
        editBT.layer.cornerRadius = 12
        
    }
    
    @IBAction func EditButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func increamentCart(index:Int){
        let Productid = products?[index].id ?? ""
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(EditCartModel.self, Requst: .increment_order(order_id: orderID, order_product_id: Productid), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                self?.products = Data?.data?.products ?? []
                self?.ProductTabelView.reloadData()
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }
    
    func decreamentCart(index:Int){
        let Productid = products?[index].id ?? ""
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(EditCartModel.self, Requst: .increment_order(order_id: orderID, order_product_id: Productid), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                self?.products = Data?.data?.products ?? []
                self?.ProductTabelView.reloadData()
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
            
        }
    }
    
    

}



extension EditOrderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EditCartCell = ProductTabelView.dequeueReusableCell(forIndexPath: indexPath)
        cell.deleteBT.isHidden = true
        
        cell.Data(product: (products?[indexPath.row])!)
        cell.incrementProducte = {
            self.increamentCart(index: indexPath.row)
        }
        cell.decrementProducte = {
            self.decreamentCart(index: indexPath.row)
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


extension EditOrderVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    
   
}

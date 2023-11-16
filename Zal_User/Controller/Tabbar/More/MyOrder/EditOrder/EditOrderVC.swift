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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Order".localize
        editBT.layer.cornerRadius = 12
        
    }
    
    @IBAction func EditButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
//    func increamentCart(index:Int){
//        let id = products[index].id ?? ""
//        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
//        NetworkManager.shared.getData(CartModel.self, Requst: .cartincrement(id: id), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
//            self?.closeIndicator()
//            if Code == 200 {
//                self?.products = Data?.data?.products ?? []
//                let count = self?.productList.count ?? 0
//                self?.vc.countTabel(count: count)
//                self?.vc.dataReload()
//        
//            }else{
//                self?.vc.errormassage(msg: Data?.message ?? "")
//            }
//            
//        }
//    }
    
    

}



extension EditOrderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EditCartCell = ProductTabelView.dequeueReusableCell(forIndexPath: indexPath)
        cell.deleteBT.isHidden = true
        
        cell.Data(product: (products?[indexPath.row])!)
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
        
    }
    
}


extension EditOrderVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    
   
}

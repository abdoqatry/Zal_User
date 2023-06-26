//
//  OrderDetailsVC.swift
//  Zal_User
//
//  Created by Admin on 26/06/2023.
//

import UIKit

class OrderDetailsVC: UIViewController,OrderDetailsProtocol {
    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func getData(num: String, address: String, paymentType: String, price: Double, discount: Double, tax: Double, delivery: Double, total: Double) {
        orderNumLabel.text = num
        addresLAbel.text = address
        paymentLabel.text = paymentType
        priceLabel.text = String(price)
        discountLabel.text = String(discount)
        taxLabel.text = String(tax)
        deliveryLabel.text = String(delivery)
        totalLAbel.text = String(total)
    }
    
    func navigationBack() {
        
    }
    
    
    @IBOutlet weak var addresLAbel: UILabel!
    @IBOutlet weak var orderNumLabel: UILabel!
    @IBOutlet weak var totalLAbel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var TabelHeight: NSLayoutConstraint!
    @IBOutlet weak var orderDetailTabel: UITableView!{
        didSet {
            orderDetailTabel.delegate = self
            orderDetailTabel.dataSource = self
            orderDetailTabel.registerCell(withCellType: OrderDetailsCell.self)
        }
    }
    
    var id = ""
    var presenter : OrderDetailsPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Order Details"
        presenter = OrderDetailsPresenter(self)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getOrderDetails(id: id)
    }
    

}



extension OrderDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.GettransCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderDetailsCell = orderDetailTabel.dequeueReusableCell(forIndexPath: indexPath)
        presenter?.configureType(cell: cell, index: indexPath.row)
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

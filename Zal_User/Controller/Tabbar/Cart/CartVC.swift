//
//  CartVC.swift
//  Zal_User
//
//  Created by Admin on 13/03/2023.
//

import UIKit

class CartVC: UIViewController,CartProtocol {
    func setData(itemNum:String,amount:String,discountPer:String,deleveryFees:String,totalAmount:String,vat:String,orderNum : String) {
        itemNumLabel.text = itemNum
        amountLabel.text = amount
        discountNumLabel.text = discountPer
        deliveryFeeLabel.text = deleveryFees
        totalAmountLabel.text = totalAmount
        servicesVatLabe.text = vat
        self.orderNum = orderNum
    }
    
    func errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func dataReload() {
        cartProductTabelView.reloadData()
    }
    
    func countTabel(count:Int){
        if count == 1 {
            ProductionTabelHeight.constant = 150
            nodataView.isHidden = true
            nodataLabel.isHidden = true
        }else if count == 0 {
            ProductionTabelHeight.constant = 0
            nodataView.isHidden = false
            nodataLabel.isHidden = false
        }else{
            ProductionTabelHeight.constant = 290
            nodataView.isHidden = true
            nodataLabel.isHidden = true
        }
    }

    @IBOutlet weak var cartProductTabelView: UITableView!{
        didSet {
            cartProductTabelView.delegate = self
            cartProductTabelView.dataSource = self
            cartProductTabelView.registerCell(withCellType: CartProductCell.self)
        }
    }
    @IBOutlet weak var nodataView: UIView!
    @IBOutlet weak var nodataLabel: UILabel!
    @IBOutlet weak var confirmBT: UIButton!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var itemNumLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var discountNumLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descountBT: UIButton!
    @IBOutlet weak var servicesVatLabe: UILabel!
    @IBOutlet weak var descountTF: UITextField!
    @IBOutlet weak var ProductionTabelHeight: NSLayoutConstraint!
    
    var orderNum = ""
    var presenter : CartPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CartPresenter(self)
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getCart()
    }
    
    func setView(){
        title = "Cart"
        discountView.layer.cornerRadius = 12
        discountView.layer.borderWidth = 0.5
        discountView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        descountBT.layer.cornerRadius = 12
        confirmBT.layer.cornerRadius = 12
    }
    
    @IBAction func discountButton(_ sender: UIButton) {
    }
    
    @IBAction func ConfirmButton(_ sender: UIButton) {
        let vc = Bundle.main.loadNibNamed("CheckOutVC", owner: nil, options: nil)![0] as! CheckOutVC
        vc.orderNumLabel.text = orderNum
        vc.orderAmountLabel.text = amountLabel.text
        vc.deliverChargeLabel.text = deliveryFeeLabel.text
        vc.totalLabel.text = totalAmountLabel.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



extension CartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.GetCartCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartProductCell = cartProductTabelView.dequeueReusableCell(forIndexPath: indexPath)
        
        presenter?.configureType(cell: cell, index: indexPath.row)
        
        cell.incrementProducte = {
            self.presenter?.increamentCart(index: indexPath.row)
        }
        cell.decrementProducte = {
            self.presenter?.decreamentCart(index: indexPath.row)
        }
        
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


extension CartVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    
   
}

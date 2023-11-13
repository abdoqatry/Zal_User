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
    func getData(time: String, location: String, productPrice: String, discount: String, paymenttype: String, delivery: String, total: String, status: String,vat:String,creatTime:String,appAmount:Double,providerAmount:Double,lat:String,lng:String,ispaided:Bool) {
//        self.ispaided = ispaided
        if time != "" {
            timeLabel.text = converttime(time)
            DateLabel.text = convertdateformate(time)
        }
        if creatTime != "" {
            timeLabelrecived.text = converttime(creatTime)
            DateLabelrecived.text = convertdateformate(creatTime)
        }
//        latetiud = Double(lat) ?? 0.0
//        longtiud = Double(lng) ?? 0.0
        locationLabel.text = location
        priceLabel.text = ("\(productPrice) \("SR".localize)")
        discountLabel.text = ("\(discount) \("SR".localize)")
        paymentTypeLabel.text = paymenttype
        deliveryFessLabel.text = ("\(delivery) \("SR".localize)")
        totallLabel.text = ("\(total) \("SR".localize)")
//        vatLabel.text = ("\(appAmount) \("SR".localize)")
//        checkStatus(status: status)
//        totalAmountLabel.text = ("\(providerAmount) \("SR".localize)")
    }
    
//    func getData(num: String, address: String, paymentType: String, price: Double, discount: Double, tax: Double, delivery: Double, total: Double) {
////        orderNumLabel.text = num
////        addresLAbel.text = address
////        paymentLabel.text = paymentType
////        priceLabel.text = String(price)
////        discountLabel.text = String(discount)
////        taxLabel.text = String(tax)
////        deliveryLabel.text = String(delivery)
////        totalLAbel.text = String(total)
//    }
    
    func navigationBack() {
        
    }
    
    func reloadTabel(){
        orderDetailTabel.reloadData()
    }
    
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var deliveryView: UIView!
    @IBOutlet weak var pymentTypeView: UIView!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var totallLabel: UILabel!
    @IBOutlet weak var deliveryFessLabel: UILabel!
    @IBOutlet weak var paymentTypeLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var vatLabel: UILabel!
//    @IBOutlet weak var VatView: UIView!
//    @IBOutlet weak var AmountLabel: UILabel!
//    @IBOutlet weak var AmountView: UIView!
    @IBOutlet weak var bottompriceView: NSLayoutConstraint!
    @IBOutlet weak var colapsPriceImage: UIImageView!
//    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var colapsDateImage: UIImageView!
    @IBOutlet weak var bottomDateView: NSLayoutConstraint!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var colapsDaterecivedImage: UIImageView!
    @IBOutlet weak var DateLabelrecived: UILabel!
    @IBOutlet weak var timeLabelrecived: UILabel!
    @IBOutlet weak var dateViewrecived: UIView!
    @IBOutlet weak var timeViewrecived: UIView!
    @IBOutlet weak var bottomDaterecivedView: NSLayoutConstraint!
//    @IBOutlet weak var discountLabel: UILabel!
//    @IBOutlet weak var priceLabel: UILabel!
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
        title = "Order Details".localize
        presenter = OrderDetailsPresenter(self)
        setView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getOrderDetails(id: id)
    }
    
    func setView(){
        colapsDateImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colacsDateView)))
        colapsPriceImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colacspriceView)))
        colapsDaterecivedImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colacsDateRecivedView)))
    }
    
    @objc func colacsDateRecivedView(){
          if bottomDaterecivedView.constant == 0 {
              UIView.animate(withDuration: 0.3) {
                  self.colapsDaterecivedImage.transform = CGAffineTransform(rotationAngle: .pi)
              
              }
              self.bottomDaterecivedView.constant = 25
              self.timeViewrecived.isHidden = false
              self.dateViewrecived.isHidden = false
              self.timeLabelrecived.isHidden = false
              self.DateLabelrecived.isHidden = false
          }else{
              UIView.animate(withDuration: 0.3) {
                  self.colapsDaterecivedImage.transform = CGAffineTransform.identity
              
              }
                  self.bottomDaterecivedView.constant = 0
                  self.timeViewrecived.isHidden = true
                  self.dateViewrecived.isHidden = true
                  self.timeLabelrecived.isHidden = true
                  self.DateLabelrecived.isHidden = true
          }
          
      }
    
    @objc func colacsDateView(){
          if bottomDateView.constant == 0 {
              UIView.animate(withDuration: 0.3) {
                  self.colapsDateImage.transform = CGAffineTransform(rotationAngle: .pi)
              
              }
              self.bottomDateView.constant = 25
              self.timeView.isHidden = false
              self.dateView.isHidden = false
              self.locationView.isHidden = false
              self.timeLabel.isHidden = false
              self.DateLabel.isHidden = false
              self.locationLabel.isHidden = false
          }else{
              UIView.animate(withDuration: 0.3) {
                  self.colapsDateImage.transform = CGAffineTransform.identity
              
              }
                  self.bottomDateView.constant = 0
                  self.timeView.isHidden = true
                  self.dateView.isHidden = true
                  self.locationView.isHidden = true
                  self.timeLabel.isHidden = true
                  self.DateLabel.isHidden = true
                  self.locationLabel.isHidden = true
          }
          
      }
    
    @objc func colacspriceView(){
          if bottompriceView.constant == 0 {
              UIView.animate(withDuration: 0.3) {
                  self.colapsPriceImage.transform = CGAffineTransform(rotationAngle: .pi)
              }
              self.bottompriceView.constant = 25
              self.discountView.isHidden = false
              self.pymentTypeView.isHidden = false
              self.deliveryView.isHidden = false
              self.priceView.isHidden = false
              self.totalView.isHidden = false
//              self.VatView.isHidden = false
              self.discountLabel.isHidden = false
              self.paymentTypeLabel.isHidden = false
              self.deliveryFessLabel.isHidden = false
              self.priceLabel.isHidden = false
//              self.vatLabel.isHidden = false
//              self.AmountView.isHidden = false
//              self.AmountLabel.isHidden = false
//              self.totalAmountLabel.isHidden = false
             
          }else{
              UIView.animate(withDuration: 0.3) {
                  self.colapsPriceImage.transform = CGAffineTransform.identity
              
              }
              self.bottompriceView.constant = 0
              self.discountView.isHidden = true
              self.pymentTypeView.isHidden = true
              self.deliveryView.isHidden = true
              self.priceView.isHidden = true
              self.totalView.isHidden = true
//              self.VatView.isHidden = true
              self.discountLabel.isHidden = true
              self.paymentTypeLabel.isHidden = true
              self.deliveryFessLabel.isHidden = true
              self.priceLabel.isHidden = true
//              self.vatLabel.isHidden = true
//              self.AmountView.isHidden = true
//              self.AmountLabel.isHidden = true
//              self.totalAmountLabel.isHidden = true
          }
          
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

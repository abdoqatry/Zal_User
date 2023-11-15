//
//  EditCartCell.swift
//  Zal_User
//
//  Created by Admin on 15/11/2023.
//

import UIKit

class EditCartCell: UITableViewCell {

    
    @IBOutlet weak var deleteBT: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var quintyLabel: UILabel!
    
    var incrementProducte: (() -> Void)?
    var decrementProducte: (() -> Void)?
    var delettProducte: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 12
        mainView.layer.borderColor = UIColor.darkGray.cgColor
        mainView.layer.borderWidth = 0.5
    }
 

    func Data(product:ProductElement) {
        nameLabel.text = product.product?.name
        descLabel.text = product.product?.description
        priceLabel.text = ("\(product.price)\("RS")")
        let url = URL(string: product.product?.image)
        productImage.kf.setImage(with: url)
        quintyLabel.text = String(product.quantity)
    }
    
    @IBAction func icreaseButton(_ sender: UIButton) {
     incrementProducte!()
    }
    
    @IBAction func decrementButton(_ sender: UIButton) {
      decrementProducte!()
    }
    
}

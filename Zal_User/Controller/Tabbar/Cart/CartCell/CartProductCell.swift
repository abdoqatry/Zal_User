//
//  CartProductCell.swift
//  Zal_User
//
//  Created by Admin on 13/03/2023.
//

import UIKit
import Cosmos

class CartProductCell: UITableViewCell,Reuseable,CartProductsCellView {
 

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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func Data(name: String, Image: String, price: String, countity: Int, desc: String) {
        nameLabel.text = name
        descLabel.text = desc
        priceLabel.text = ("\(price)\("RS")")
        let url = URL(string: Image)
        productImage.kf.setImage(with: url)
        quintyLabel.text = String(countity)
    }
    
    
    @IBAction func icreaseButton(_ sender: UIButton) {
     incrementProducte!()
    }
    
    @IBAction func decrementButton(_ sender: UIButton) {
      decrementProducte!()
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        delettProducte!()
    }
    
}



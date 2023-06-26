//
//  OrderDetailsCell.swift
//  Zal_User
//
//  Created by Admin on 26/06/2023.
//

import UIKit
import Cosmos

class OrderDetailsCell: UITableViewCell,Reuseable,OrderDetailsCellView {
    
    func Data(image: String, name: String, desc: String, quanty: String, price: Double) {
        nameLabel.text = name
        priceLabel.text = "\(price)\("SR".localize)"
        quanityLabel.text = quanty
        descLabel.text = desc
        let url = URL(string: image)
        productImg.kf.setImage(with: url)
    }

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quanityLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 12
        mainView.layer.borderColor = UIColor.darkGray.cgColor
        mainView.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}

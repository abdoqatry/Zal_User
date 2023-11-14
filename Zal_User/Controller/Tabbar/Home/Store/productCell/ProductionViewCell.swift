//
//  ProductionViewCell.swift
//  Zal_User
//
//  Created by Admin on 26/02/2023.
//

import UIKit
import Cosmos
import Kingfisher

class ProductionViewCell: UICollectionViewCell,Reuseable,ProductsCellView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var addtocartBT: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var favoriteBT: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    
    var favoriteProducte: (() -> Void)?
    var addToCartProducte: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 12
        mainView.layer.applySketchShadow()
    }
    
    func Data(name: String, Image: String, price: String, rate: Double, id: Int,is_liked:Bool) {
        rateView.rating = rate
        productNameLabel.text = name
        priceLabel.text = ("\(price)\(" ")\("SR".localize)")
        let url = URL(string: Image)
        productImage.kf.setImage(with: url)
        if is_liked == false {
            favoriteBT.setImage(UIImage(named: "hartEmpty"), for: .normal)
        }else{
            favoriteBT.setImage(UIImage(named: "redHart"), for: .normal)
        }
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        favoriteProducte!()
    }
    
    @IBAction func addToCartButton(_ sender: UIButton) {
        addToCartProducte!()
    }
}

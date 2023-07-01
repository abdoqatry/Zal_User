//
//  CategorycollectionCell.swift
//  Zal_User
//
//  Created by Admin on 26/02/2023.
//

import UIKit
import Kingfisher

class CategorycollectionCell: UICollectionViewCell,Reuseable,CategoryCellView {

    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageview.layer.cornerRadius = 30
        imageview.clipsToBounds = true
        imageview.layer.masksToBounds = true
    }
    
    func Data(name:String,Image:String){
        let url = URL(string: Image)
        catImage.kf.setImage(with: url)
        nameLabel.text = name
//        catImage.backgroundColor = UIColor.clear
//        catImage.isOpaque = true
    }

}

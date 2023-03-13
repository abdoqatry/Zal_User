//
//  SpecialStoreCell.swift
//  Zal_User
//
//  Created by Admin on 08/02/2023.
//

import UIKit
import Cosmos
import Kingfisher

class SpecialStoreCell: UICollectionViewCell,SpcialStoreCellView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var storNameLabel: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var CoverImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
    }
    
    func setView(){
        profileView.layer.cornerRadius = 20
        profileImage.layer.applySketchShadow()
        profileImage.layer.cornerRadius = 20
        mainView.layer.cornerRadius = 8
        mainView.layer.applySketchShadow()
    }
    
    func Data(name: String, ProfileImage: String, address: String, coverImage: String, rate: Double) {
        storNameLabel.text = name
        addressLabel.text = address
        rateView.rating = rate
        let url = URL(string: ProfileImage)
        profileImage.kf.setImage(with: url)
        let url2 = URL(string: coverImage)
        CoverImage.kf.setImage(with: url2)
        CoverImage.clipsToBounds = true
        
    }
    

}

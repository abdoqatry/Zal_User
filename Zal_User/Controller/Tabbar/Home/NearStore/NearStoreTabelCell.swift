//
//  NearStoreTabelCell.swift
//  Zal_User
//
//  Created by Admin on 12/02/2023.
//

import UIKit
import Cosmos

class NearStoreTabelCell: UITableViewCell,Reuseable,NearCellView {

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var cocntentView: UIView!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
    }
    
    func setView(){
        coverImage.layer.cornerRadius = 8
        coverImage.clipsToBounds = true
        coverImage.layer.applySketchShadow()
        profileView.layer.cornerRadius = 6
        profileView.clipsToBounds = true
        profileImage.layer.cornerRadius = 6
        cocntentView.layer.cornerRadius = 10
        cocntentView.layer.applySketchShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func Data(name: String, ProfileImage: String, address: String, CoverImage: String, rate: Int, distance: Double) {
        nameLabel.text = name
        addressLabel.text = address
        distanceLabel.text = String(distance)
        rateView.rating = Double(rate)
        let url = URL(string: ProfileImage)
        profileImage.kf.setImage(with: url)
        let url2 = URL(string: CoverImage)
        coverImage.kf.setImage(with: url2)
    }
    
}

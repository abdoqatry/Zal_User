//
//  RateStoreCell.swift
//  Zal_User
//
//  Created by Admin on 01/03/2023.
//

import UIKit
import Cosmos

class RateStoreCell: UITableViewCell,Reuseable {

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var descLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileView.layer.cornerRadius = 20
        profileView.clipsToBounds = true
        profileView.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 20
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: RateDatum ){
        nameLabel.text = viewModel.user?.name ?? ""
        rateView.rating = viewModel.rate ?? 0.0
        descLabel.text = viewModel.review ?? ""
        let url = URL(string: viewModel.user?.image ?? "")
        profileImage.kf.setImage(with: url)
     }
    
}

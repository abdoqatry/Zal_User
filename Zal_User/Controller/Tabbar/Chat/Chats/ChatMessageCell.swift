//
//  ChatMessageCell.swift
//  Zal_User
//
//  Created by Admin on 02/04/2023.
//

import UIKit

class ChatMessageCell: UITableViewCell {

    @IBOutlet weak var HomeView: UIView!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var MessageHomeView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var AwayView: UIView!
    
    @IBOutlet weak var awayPhoto: UIImageView!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var sendingLabel: UILabel!
    
    @IBOutlet weak var AwayViewContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SetView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func SetView(){
           
           HomeView.layer.cornerRadius = 20
           HomeView.clipsToBounds = true
         MessageHomeView.layer.cornerRadius = 16
        AwayView.layer.cornerRadius = 20
        AwayView.clipsToBounds = true
        AwayViewContent.layer.cornerRadius = 16
        
    }
}

//
//  IntroFirstPageVC.swift
//  Zal_User
//
//  Created by Admin on 21/02/2023.
//

import UIKit

class IntroFirstPageVC: UIViewController {

    @IBOutlet weak var nextImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            self.navigationItem.standardAppearance = appearance
            self.navigationItem.scrollEdgeAppearance = appearance
        nextImage.addGestureRecognizer(UITapGestureRecognizer(target: self
                                                              , action: #selector(nextPage)))
    }
    
    @objc func nextPage(){
        
        let vc = Bundle.main.loadNibNamed("IntroSecondPageVC", owner: nil, options: nil)![0] as! IntroSecondPageVC
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
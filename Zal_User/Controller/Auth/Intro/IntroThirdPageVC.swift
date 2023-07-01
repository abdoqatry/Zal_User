//
//  IntroThirdPageVC.swift
//  Zal_User
//
//  Created by Admin on 21/02/2023.
//

import UIKit

class IntroThirdPageVC: UIViewController {

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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            self.navigationItem.standardAppearance = appearance
            self.navigationItem.scrollEdgeAppearance = appearance
    }
    
    @objc func nextPage(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")  as! LoginVC
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

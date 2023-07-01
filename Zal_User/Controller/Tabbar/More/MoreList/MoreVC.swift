//
//  MoreVC.swift
//  Zal_User
//
//  Created by Admin on 15/02/2023.
//

import UIKit

class MoreVC: UIViewController {

    @IBOutlet weak var moreTabelView: UITableView!{
        didSet {
            moreTabelView.delegate = self
            moreTabelView.dataSource = self
            moreTabelView.registerCell(withCellType: MoreCell.self)
        }
    }
    
    var dumyDate  = [dummyItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "More".localize
//        setupNavigationBar()
      addDate()
    }
    
    func addDate(){
//        dumyDate.append(dummyItem(name: "Profile",image: "Group 24189"))
        dumyDate.append(dummyItem(name: "My Order".localize,image: "Group 24190"))
        dumyDate.append(dummyItem(name: "My Favorite".localize,image: "Group 24191"))
        dumyDate.append(dummyItem(name: "Settings".localize, image: "Group 24192"))
        dumyDate.append(dummyItem(name: "About us".localize,image: "Group 24193"))
        dumyDate.append(dummyItem(name: "Terms and condition".localize,image: "Group 24194"))
        dumyDate.append(dummyItem(name: "Contact us".localize,image: "Group 24194"))
        dumyDate.append(dummyItem(name: "Log out".localize,image: "logout"))
        print(dumyDate.count)
    moreTabelView.reloadData()
        
    }
    

}


extension MoreVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dumyDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MoreCell = moreTabelView.dequeueReusableCell(forIndexPath: indexPath)
//        presenter.configureRecipeCell(cell: cell, index: indexPath.row)
        cell.selectionStyle = .none
        cell.configure(viewModel: dumyDate[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.selectRecipeCell(index: indexPath.row, RecipeId: 1)
//        if indexPath.row == 0 {
//            let vc = Bundle.main.loadNibNamed("ProfileVC", owner: nil, options: nil)![0] as! ProfileVC
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else
        if indexPath.row == 0 {
            let vc = Bundle.main.loadNibNamed("MyOrderVC", owner: nil, options: nil)![0] as! MyOrderVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 {
            let vc = Bundle.main.loadNibNamed("FavoriteVC", owner: nil, options: nil)![0] as! FavoriteVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 7 {
            AuthService.instance.Logout()
        }
        
    }
    
}


extension MoreVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
        
    }
    
   
}

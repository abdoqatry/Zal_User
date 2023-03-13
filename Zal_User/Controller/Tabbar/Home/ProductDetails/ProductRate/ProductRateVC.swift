//
//  ProductRateVC.swift
//  Zal_User
//
//  Created by Admin on 01/03/2023.
//

import UIKit

class ProductRateVC: UIViewController {

    @IBOutlet weak var NodataLabel: UILabel!
    @IBOutlet weak var RateTabelView: UITableView!{
        didSet {
            RateTabelView.delegate = self
            RateTabelView.dataSource = self
            RateTabelView.registerCell(withCellType: RateStoreCell.self)
        }
    }
    
    var id = ""
    
    var rateArray : [RateDatum]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRate(id: id)
    }
    
    
    func getRate(id:String){
        openIndicator(title:Constants.PLEASE_WAIT , description: Constants.LOADING_DATA)
        NetworkManager.shared.getData(RateModel.self, Requst: .product_rates(id: id), method: .get, headerType: .authenticated) {[weak self] (Massage, Data, Code) in
            self?.closeIndicator()
            if Code == 200 {
                if Data?.data?.count != 0 {
                self?.rateArray = Data?.data ?? []
                self?.RateTabelView.reloadData()
                    self?.NodataLabel.isHidden = true
                }else{
                    self?.NodataLabel.isHidden = false
                }
                
            }else{
                self?.showAlert(title: Data?.message ?? "", messages: nil, message: nil, selfDismissing: true)
            }
        }
    }
    
    

}


extension ProductRateVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rateArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RateStoreCell = RateTabelView.dequeueReusableCell(forIndexPath: indexPath)
        
        cell.configure(viewModel: (rateArray?[indexPath.row])! )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.selectRecipeCell(index: indexPath.row, RecipeId: 1)
//        let vc = Bundle.main.loadNibNamed("ProductDetailsVC", owner: nil, options: nil)![0] as! ProductDetailsVC
//        vc.id = "1"
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension ProductRateVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
   
}

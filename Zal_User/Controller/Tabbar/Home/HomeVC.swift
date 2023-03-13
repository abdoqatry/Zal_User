//
//  HomeVC.swift
//  Zal_User
//
//  Created by Admin on 08/02/2023.
//

import UIKit
import ImageSlideshow

class HomeVC: UIViewController,HomeProtocol {
    
    func dataReload() {
        SpecialStoreCollection.reloadData()
        nearStoreCollection.reloadData()
    }
    
    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func setSlidertData(slider: [sliderModel]) {
        Images = slider
    }
    
    func selectIndex(id : String){
        let vc = Bundle.main.loadNibNamed("StoreVC", owner: nil, options: nil)![0] as! StoreVC
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var addressImage: UIImageView!
    @IBOutlet weak var showNearStoreBT: UIButton!
    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var SpecialStoreCollection: UICollectionView!
    @IBOutlet weak var nearStoreCollection: UICollectionView!
    @IBOutlet weak var ViewSlider: UIView!
    @IBOutlet weak var ImageSliderView: ImageSlideshow!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    var Images = [sliderModel](){
        didSet{
            var sliderImages = [KingfisherSource]()
            Images.forEach() {
                guard let imageSource = KingfisherSource(urlString: $0.image ?? "") else {return}
                sliderImages.append(imageSource)
            }
            ImageSliderView.setImageInputs(sliderImages)

            ImageSliderView.reloadInputViews()
        }
    }
    
    var presenter : HomePresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(self)
        presenter?.getHome(lat: <#String#>, lng: <#String#>, keyword: <#String#>)
        SpecialStoreCollection.register(UINib(nibName: "SpecialStoreCell", bundle: nil), forCellWithReuseIdentifier: "SpecialStoreCell")
        nearStoreCollection.register(UINib(nibName: "NearStoreCell", bundle: nil), forCellWithReuseIdentifier: "NearStoreCell")
        let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            self.navigationItem.standardAppearance = appearance
            self.navigationItem.scrollEdgeAppearance = appearance
        SetSiliderImages()
        setView()
        presenter?.getSlider()
        setupNavigationBar()
        
    }
    
    
    func SetSiliderImages(){
        let pageIndicator = UIPageControl()
             pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
             pageIndicator.pageIndicatorTintColor = #colorLiteral(red: 0.5450980392, green: 0, blue: 0.2980392157, alpha: 1)
        ImageSliderView.pageIndicator = pageIndicator
        ImageSliderView.contentScaleMode = .scaleAspectFill
        ImageSliderView.slideshowInterval = 5.0
        
    }
    
    func setView(){
        let auth = AuthService.instance
        ViewSlider.layer.cornerRadius = 16
        ViewSlider.clipsToBounds = true
        nameLabel.text = auth.username ?? ""
        addressLabel.text = auth.userAddress ?? ""
        linedBt(Button: showNearStoreBT, tittle:"Show All".localize, color: colorWithHexString(hexString: "#8B004C"))
        if AuthService.instance.authToken != nil {
            nameLabel.text = auth.username ?? ""
            addressLabel.text = auth.userAddress ?? ""
            locationImage.isHidden = false
            addressImage.isHidden = false
        }else{
            nameLabel.text = "welcome to Zal application"
            addressLabel.text = ""
            locationImage.isHidden = true
            addressImage.isHidden = true
        }
        addressImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.getAddress)))
        addressLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.getAddress)))
    }
    
    @objc func getAddress(){
         let vc = AddressPositionVC()
        self.view.endEditing(true)
        
        vc.delegetAddress = self
         presentPop(viewController: vc)
     }
    
    @IBAction func ShowAllTransActionButton(_ sender: UIButton) {
        let vc = Bundle.main.loadNibNamed("NearStoreVC", owner: nil, options: nil)![0] as! NearStoreVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}



extension HomeVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {


func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == SpecialStoreCollection {
      return  presenter?.GetSpecialCount() ?? 0
    }else{
      return  presenter?.GetnearCount() ?? 0
    }
    
      }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == SpecialStoreCollection {
            let cell = SpecialStoreCollection.dequeueReusableCell(withReuseIdentifier: "SpecialStoreCell", for: indexPath) as! SpecialStoreCell
            
            presenter?.configureType(cell: cell, index: indexPath.row)
            return cell
        }else {
            let cell = nearStoreCollection.dequeueReusableCell(withReuseIdentifier: "NearStoreCell", for: indexPath) as! NearStoreCell
            
            presenter?.configureNear(cell: cell, index: indexPath.row)
            
            return cell
        }
           
    }

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == SpecialStoreCollection {
        return .init(width: 200, height: 210)
    }else{
        return .init(width: 320, height: 210)
    }
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 5
   }

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == SpecialStoreCollection {
        presenter?.selecteSpecialCell(index: indexPath.row)
    }else{
        presenter?.selecteNearCell(index: indexPath.row)
    }
    
}
    


}


extension HomeVC:Addressprotocole{
    
    func passAddress(value: String, Id: Int, lat: String, lon: String, code: String) {
        if value != "" {
            addressLabel.text = value
        }
    }
}

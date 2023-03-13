//
//  ProductDetailsVC.swift
//  Zal_User
//
//  Created by Admin on 01/03/2023.
//

import UIKit
import ImageSlideshow

class ProductDetailsVC: UIViewController,ProductDetailsProtocol {
    
    func Errormassage(msg: String) {
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
    }
    
    func setData(coverImage: [Image], name: String, price: String) {
        Images = coverImage
        priceLabel.text = "\(price)\("SR".localize)"
        nameLabel.text = name
    }
    
    var Images = [Image](){
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

    @IBOutlet weak var addtocartBT: UIButton!
    @IBOutlet weak var PriceView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ImageSliderView: ImageSlideshow!
    @IBOutlet weak var segmantsubView: UISegmentedControl!
    @IBOutlet weak var MainView: UIView!
    
    var productid = ""
    var catId = ""
    var providerId = ""
    var presenter : ProductDetailsPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProductDetailsPresenter(self)
        let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            self.navigationItem.standardAppearance = appearance
            self.navigationItem.scrollEdgeAppearance = appearance
        addtocartBT.layer.cornerRadius = 12
        PriceView.layer.cornerRadius = 4
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getProduct(id: productid)
        
        addRate()
    }
    
    @IBAction func SegmantDetailBT(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
            addRate()
            
        }else if sender.selectedSegmentIndex == 0 {
//            addproduct()
        }
        
    }

    
    @IBAction func addtoCartButton(_ sender: UIButton) {
        
    }
    
    
    func addRate(){
        MainView.subviews.forEach({ $0.removeFromSuperview() })
        let vc = Bundle.main.loadNibNamed("ProductRateVC", owner: nil, options: nil)![0] as! ProductRateVC
        vc.id = productid
    let controller = vc
    addChild(controller)
        MainView.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
//    contantView.translatesAutoresizingMaskIntoConstraints = true
        MainView.addSubview(controller.view)
  
    controller.didMove(toParent: self)
    controller.view.frame = CGRect(x:0, y: 0, width: MainView.frame.width, height: MainView.frame.height)
    }
    
    
}

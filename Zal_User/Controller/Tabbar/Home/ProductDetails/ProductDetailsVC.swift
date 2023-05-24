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
    
    func setData(coverImage: [Image], name: String, price: String,description:String) {
        Images = coverImage
        priceLabel.text = "\(price)\("SR".localize)"
        nameLabel.text = name
        descLabel.text = description
    }
    
    func addToCart(msg:String){
        showAlert(title: msg, messages: nil, message: nil, selfDismissing: true)
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

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var quentityLabel: UILabel!
    @IBOutlet weak var addtocartBT: UIButton!
    @IBOutlet weak var PriceView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ImageSliderView: ImageSlideshow!
    
    var productid = ""
    var catId = ""
    var providerId = ""
    var presenter : ProductDetailsPresenter?
    var quantity = 0
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
    }
    
   
    @IBAction func decreaseBT(_ sender: UIButton) {
        quantity = Int(quentityLabel.text!)!
        print(quantity)
        if quentityLabel.text! > "0" {
           let x = quantity - 1
            print(x)
            quentityLabel.text = String(x)
        }
    }
    
    @IBAction func increesBT(_ sender: UIButton) {
        quantity = Int(quentityLabel.text!)!
        print(quantity)
//        if quentityLabel.text! > "0" {
           let x = quantity + 1
            print(x)
            quentityLabel.text = String(x)
//        }

    }
    
    
    @IBAction func addtoCartButton(_ sender: UIButton) {
        presenter?.storeCart(id: productid, quantity: quentityLabel.text ?? "")
    }
    
    
   
    
    
}

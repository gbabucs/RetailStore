//
//  ProductDetailViewController.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/17/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import UIKit
import ReusableFramework

class ProductDetailViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    // MARK: - Properities
    
    var productDetail: ProductDetail?

    // MARK: - View LIfeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        updateView()
    }
    
    // MARK: - Helpers
    
    func configureView() {
        name.text = productDetail?.name
        image.image = productDetail?.image
        price.text = "₹\(String(describing: productDetail?.price ?? 0.0))"
    }
    
    func updateView() {
        _ = isModal ? addCloseButton() : addCartButton()
        self.title = productDetail?.name
    }
    
    func addCartButton() {
        let cartButton = UIBarButtonItem(image: UIImage(named: "cart30"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProductDetailViewController.cartScreen))
        
        self.navigationItem.rightBarButtonItem = cartButton
    }
    
    func addCloseButton() {
        let closeButton = UIBarButtonItem(image: UIImage(named: "close"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProductDetailViewController.close))
        let navigationBar = UINavigationBar(frame: CGRect(x: 0.0, y: 20.0, width: view.frame.size.width, height: 44.0))
        let navigationBarItem = UINavigationItem(title: productDetail?.name ?? "")
        
        navigationBarItem.rightBarButtonItem = closeButton
        
        navigationBar.setItems([navigationBarItem], animated: true)
        navigationBar.isTranslucent = false
        
        self.view.addSubview(navigationBar)
    }
    
    @objc
    func cartScreen(){
        let cartViewController = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        
        self.present(cartViewController, animated: true, completion: nil)
    }
    
    @objc
    func close(){
        guard let cartViewController = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController else {
            return
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Action
    
    @IBAction func addToCart(sender: UIButton) {
        guard let id = productDetail?.id else {
            return
        }
        
        DataProvider.shared.update(productId: id, isAddedToCart: true, quantity: 1)
    }
    
    
}

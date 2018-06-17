//
//  CartViewController.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/17/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    // MARK: - Properties
    
    private var cartDataSource: [ProductDetail]?
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Cart Button
        let closeButton = UIBarButtonItem(image: UIImage(named: "close"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(CartViewController.close))
        
        let navigationBarItem = UINavigationItem(title: "Cart")
        
        navigationBarItem.rightBarButtonItem = closeButton
        
        navigationBar.setItems([navigationBarItem], animated: true)
    
        refreshData()
    }
    
    // MARK: - Helpers
    
    
    func refreshData() {
        self.cartDataSource = DataProvider.shared.cartDataBuilder()
        self.tableView.reloadData()
        self.updateView()
    }
    
    func updateView() {
        guard let products = self.cartDataSource,
            products.count > 0 else {
                return self.totalPrice.text = "Total Price:"
        }
        
        var total = 0.0
        
        for product in products {
            total += product.price!
        }
        
        self.totalPrice.text = "Total Price: ₹\(total)"
    }

    @objc
    func close(){
        guard let cartViewController = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController else {
            return
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func showProductDetailScreenViewController(product: ProductDetail) {
        guard let productDetailViewController = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController else { return }
        
        productDetailViewController.productDetail = product
        
        self.present(productDetailViewController, animated: true, completion: nil)
    }

}

// MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = cartDataSource
            else { return }
        let product = data[indexPath.row]
        
        showProductDetailScreenViewController(product: product)
    }
    
}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.reuseIdentifier, for: indexPath) as? CartTableViewCell,
            let data = cartDataSource,
            data.count > 0 else {
                return UITableViewCell()
        }
        
        cell.configure(with: data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            guard let data = cartDataSource,
                let id = data[indexPath.row].id
                else { return }
            
            DataProvider.shared.update(productId: id, isAddedToCart: false, quantity: 0)
            refreshData()
        }
    }
}

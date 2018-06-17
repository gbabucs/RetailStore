//
//  ListViewController.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/17/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: ListDataSource?
    var selectedProduct: ProductDetail?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let product = DataProvider.shared.fetchAllProducts()

        self.title = "Products"
        
        self.dataSource  = ListDataSource(data: product)
        self.addCartButton()
    }
    
    // MARK: - Helpers
    
    func addCartButton() {
        let cartButton = UIBarButtonItem(image: UIImage(named: "cart30"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProductDetailViewController.cartScreen))
        
        self.navigationItem.rightBarButtonItem = cartButton
    }
    
    @objc
    func cartScreen(){
        let cartViewController = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        
        self.present(cartViewController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductDetailViewController" {
            guard let productDetailViewController = segue.destination as? ProductDetailViewController,
                let productDetail = sender as? ProductDetail
                else { return }
            
            productDetailViewController.productDetail = productDetail
        }
    }

}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            let item = try dataSource!.item(at: indexPath)
        
            selectedProduct = item.productDetail
            
            performSegue(withIdentifier: "showProductDetailViewController", sender: item.productDetail)
        }
        catch {}
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource?.numberOfSections ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try dataSource!.numberOfItems(at: section)
        }
        catch {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        do {
            let data = try dataSource!.item(at: indexPath)
            
            cell.configure(with: data)
        }
        catch {}
        
        return cell
    }
}


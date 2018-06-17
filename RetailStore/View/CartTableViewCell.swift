//
//  CartTableViewCell.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/17/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import UIKit
import ReusableFramework

class CartTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
}

// MARK: - Cell

extension CartTableViewCell: Cell {
    typealias DataType = ProductDetail
    
    func configure(with data: ProductDetail) {
        
        price.text = "₹\(String(describing: data.price ?? 0.0))"
        name.text = data.name
        productImageView.image = data.image
        
    }
    
}

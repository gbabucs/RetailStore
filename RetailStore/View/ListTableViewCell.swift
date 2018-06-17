//
//  ListTableViewCell.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/17/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var name: UILabel!
}

// MARK: - Cell

extension ListTableViewCell: Cell {
    typealias DataType = ProductListItem
    
    func configure(with item: ProductListItem) {
        name.text = item.productDetail?.name
    }
    
}

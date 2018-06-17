//
//  ProductListItem.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/18/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import Foundation

struct ProductListItem {
    var productDetail: ProductDetail?
}

// MARK: - Itemable

extension ProductListItem: Itemable {}

// MARK: - CustomStringConvertible

extension ProductListItem: CustomStringConvertible {
    
    // MARK: Properties
    
    var description: String {
        return ""
    }
    
}

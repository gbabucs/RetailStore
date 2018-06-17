//
//  ProductListSection.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/18/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import Foundation

struct ProductListSection {
    var index: Int
    var id: String
    var type: CategoryType?
}

// MARK: - Sectionable

extension ProductListSection: Sectionable {}

// MARK: - CustomStringConvertible

extension ProductListSection: CustomStringConvertible {
    
    // MARK: Properties
    
    var description: String {
        return ""
    }
}

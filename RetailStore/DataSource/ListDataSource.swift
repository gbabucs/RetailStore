//
//  ListDataSource.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/17/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import Foundation
import UIKit


class ListDataSource {
    
    // MARK: Types
    
    typealias SourceData = [Product]
    typealias Section = ProductListSection
    typealias Item = ProductListItem
    
    // MARK: Properties
    
    var data: [Section : [Item]]
    var sourceData: SourceData?
    
//    var numberOfSections: Int {
//        return data.keys.count
//    }
    
    // MARK: Initializers
    
    required init() {
        data = [:]
    }

}

extension ListDataSource: DataSource {
    
    func load() {
        guard let products = sourceData else {
            return
        }
        
        var sections = [ProductListSection]()
        var items = [Item]()
        
        for product in products {
            if let category = product.category {
                let section = Section(index: 0, id: category , type: CategoryType(rawValue: category))
                if sections.contains(section) == false {
                    sections.append(section)
                }
            }
            
            let item = makeItem(from: product)
            
            items.append(item)
        }
        
        let uniqueCategories = Array(Set(sections))
        
        var index = 0
        
        for category in uniqueCategories {
            var section = category
            section.index = index
            
            data[section] = items.filter {
                $0.productDetail?.category == category.type?.rawValue
            }
            index += 1
        }
    }
    
    func makeItem(from product: Product) -> Item {
        var item = Item()
        
        guard let data = product.image as Data?,
            let image = UIImage(data: data) else {
                return item
        }
        
        let productDetail = ProductDetail(id: product.id, name: product.name, price: product.price, image: image, category: product.category, quantity: product.quantity, isAddedToCart: product.isAddedToCart)
        
        item.productDetail = productDetail
        
        return item
    }
}

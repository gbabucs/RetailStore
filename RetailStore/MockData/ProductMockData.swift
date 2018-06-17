//
//  ProductMockData.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/17/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import Foundation
import UIKit

class ProductMockData {
    
    static let shared = ProductMockData()
    private let dataProvider = DataProvider()
    
    //MARK: - Mock data for Database
    var productDetails: [ProductDetail] {
        let image1 = UIImage(named: "microwave_oven")
        let image2 = UIImage(named: "television")
        let image3 = UIImage(named: "vacuum_cleaner")
        let image4 = UIImage(named: "chair")
        let image5 = UIImage(named: "table")
        let image6 = UIImage(named: "almirah")
    
        let product1 = ProductDetail(id: "1", name: "Microwave Oven", price: 4999.00, image: image1, category: "Electronics", quantity: 0, isAddedToCart: false)
        let product2 = ProductDetail(id: "2", name: "Television", price: 15999.0, image: image2, category: "Electronics", quantity: 0, isAddedToCart: false)
        let product3 = ProductDetail(id: "3", name: "Vacuum Cleaner", price: 6999.00, image: image3, category: "Electronics", quantity: 0, isAddedToCart: false)
        let product4 = ProductDetail(id: "4", name: "Chair", price: 4599.00, image: image4, category: "Furniture", quantity: 0, isAddedToCart: false)
        let product5 = ProductDetail(id: "5", name: "Table", price: 2499.00, image: image5, category: "Furniture", quantity: 0, isAddedToCart: false)
        let product6 = ProductDetail(id: "6", name: "Almirah", price: 6799.00, image: image6, category: "Furniture", quantity: 0, isAddedToCart: false)
        
        return [product1, product2, product3, product4, product5, product6]
    }
    
    //MARK: - Build DataBaxse
    func feedDataToDatabase() {
        guard let products = DataProvider().fetchAllProducts() as? [Product],
            products.count == 0 else {
                return
        }
        
        for product in productDetails {
            DataProvider.shared.addProduct(product)
        }

    }
}

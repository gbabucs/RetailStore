//
//  DataProvider.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/17/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataProvider {
    
    static let shared = DataProvider()
    
    let coreDataManager = CoreDataManager()
    
    
    func fetchAllProducts() -> [Product] {
        let viewContext = coreDataManager.persistentContainer.viewContext
        let fetchRequest = Product.fetchProductRequest()
        
        var products: [Product]?
        
        do {
            products = try viewContext.fetch(fetchRequest)
        } catch {
            print("\(error.localizedDescription)")
        }
        
        return products ?? []
    }
    
    func fetchAddedCartProducts() -> [Product] {
        let viewContext = coreDataManager.persistentContainer.viewContext
        let fetchRequest = Product.fetchProductRequest()
        
        var products: [Product]?

        fetchRequest.predicate = NSPredicate(format: "isAddedToCart"+" == 1")
        
        do {
            products = try viewContext.fetch(fetchRequest)
        } catch {
            print("\(error.localizedDescription)")
        }
        
        return products ?? []
    }
    
    func update(productId: String, isAddedToCart: Bool, quantity: Int32) {
        let viewContext = coreDataManager.persistentContainer.viewContext
        let fetchRequest = Product.fetchProductRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id"+" == %@", productId)
        
        let products = try? viewContext.fetch(fetchRequest)
        
        if let product = products?.first {
            product.isAddedToCart = isAddedToCart
            product.quantity = product.quantity + quantity
            
            coreDataManager.saveContext()
        }
    }
    
    func cartDataBuilder() -> [ProductDetail] {
        let products = self.fetchAddedCartProducts()
    
        return products.flatMap { adapt($0) }
    }
    
    func adapt(_ product: Product) -> ProductDetail? {
        guard let data = product.image as Data?,
            let image = UIImage(data: data) else {
                return nil
        }
        
        return ProductDetail(id: product.id, name: product.name, price: product.price, image: image, category: product.category, quantity: product.quantity, isAddedToCart: product.isAddedToCart)
    }
    
    
    func addProduct(_ productDetail: ProductDetail) {
        let managedContext = coreDataManager.persistentContainer.viewContext
        
        if let product = NSEntityDescription.insertNewObject(forEntityName: "Product", into: managedContext) as? Product {
            product.name = productDetail.name
            product.id = productDetail.id
            product.price = productDetail.price ?? 0.0
            
            if let image = productDetail.image,
                let category = productDetail.category {
                product.image = UIImagePNGRepresentation(image) as NSData?
                product.category = CategoryType(rawValue: category).map { $0.rawValue }
            }
        }
        
        coreDataManager.saveContext()
    }
}

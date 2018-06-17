//
//  ProductDetail.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/17/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import Foundation
import UIKit

struct ProductDetail {
    var id: String?
    var name: String?
    var price: Double?
    var image: UIImage?
    var category : String?
    var quantity: Int32? = 0
    var isAddedToCart: Bool = false
}

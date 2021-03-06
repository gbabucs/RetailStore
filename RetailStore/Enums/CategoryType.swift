//
//  CategoryType.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/17/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import Foundation

enum CategoryType: String {
    case electronics = "Electronics"
    case furniture = "Furniture"
    
    var title: String {
        return "\(self.rawValue)"
    }

}

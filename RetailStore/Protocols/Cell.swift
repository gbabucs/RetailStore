//
//  Cell.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/17/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import Foundation

protocol Cell {
    
    associatedtype DataType
    
    static var reuseIdentifier: String { get }
    
    func setupCell()
    func configure(with data: DataType)
}


//MARK: Cell Extension

extension Cell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func setupCell() {}
    func configure(with data: DataType) {}
}

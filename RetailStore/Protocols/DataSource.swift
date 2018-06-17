//
//  DataSource.swift
//  RetailStore
//
//  Created by Babu Gangatharan on 6/17/18.
//  Copyright © 2018 Babu Gangatharan. All rights reserved.
//

import Foundation

protocol DataSource: class {

    associatedtype SourceData
    associatedtype Section: Sectionable
    associatedtype Item: Itemable
    
    // MARK: Properties
    
    var data: [Section: [Item]] { get set }
    
    /// The source of data for the `data` dictionary.
    var sourceData: SourceData? { get set }
    
    var numberOfSections: Int { get }
    
    // MARK: Initializers
    
    init()
    
    init(data: SourceData)
    
    // MARK: Functions
    
    func load()
    
    func numberOfItems(at sectionIndex: Int) throws -> Int
    
    func items(at sectionIndex: Int) throws -> [Item]
    
    func items(at indexPaths: [IndexPath]) throws -> [Item]
    
    func section(at sectionIndex: Int) throws -> Section
    
    func item(at indexPath: IndexPath) throws -> Item
    
}

extension DataSource {
    
    // MARK: Properties
    
    /// The number of sections on the dictionary.
    var numberOfSections: Int {
        return data.keys.count
    }
    
    // MARK: Initializers
    
    init(data: SourceData) {
        self.init()
        
        self.data = [:]
        self.sourceData = data
        
        load()
    }
    
    // MARK: Functions
    
    
    func numberOfItems(at sectionIndex: Int) throws -> Int {
        guard numberOfSections > 0 else {
            return 0
        }
        
        let section = try self.section(at: sectionIndex)
        let items = data[section]!
        
        return items.count
    }
    
    func items(at sectionIndex: Int) throws -> [Item] {
        guard try numberOfItems(at: sectionIndex) > 0 else {
            throw DataSourceError.itemsEmpty
        }
        
        let section = try self.section(at: sectionIndex)
        
        return data[section]!
    }
    
    func items(at indexPaths: [IndexPath]) throws -> [Item] {
        var items = [Item]()
        
        for indexPath in indexPaths {
            guard try numberOfItems(at: indexPath.section) > 0 else {
                throw DataSourceError.itemsEmpty
            }
            
            let item = try self.item(at: indexPath)
            
            items.append(item)
        }
        
        return items
    }
    
    func section(at sectionIndex: Int) throws -> Section {
        guard numberOfSections > 0 else {
            throw DataSourceError.sectionsEmpty
        }
        guard sectionIndex <= numberOfSections - 1 else {
            throw DataSourceError.sectionIndexOutOfBounds
        }
        
        return data.keys.filter({ $0.index == sectionIndex }).first!
    }
    
    func item(at indexPath: IndexPath) throws -> Item {
        guard try numberOfItems(at: indexPath.section) > 0 else {
            throw DataSourceError.itemsEmpty
        }
        
        let section = try self.section(at: indexPath.section)
        let items = data[section]!
        
        guard indexPath.row <= items.count - 1 else {
            throw DataSourceError.itemIndexOutOfBounds
        }
        
        return items[indexPath.row]
    }
}

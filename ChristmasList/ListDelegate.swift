//
//  ListDelegate.swift
//  ChristmasList
//
//  Created by DLM on 11/13/18.
//  Copyright © 2018 DLM. All rights reserved.
//

import UIKit

protocol addItemDelegate: class {
    func addButtonPressed()
    func editButtonPressed(by controller:ItemDetailViewController, with itemName:String, personName:String, categoryDescription:String)
    func save(item:Item, indexPath: IndexPath?)
}

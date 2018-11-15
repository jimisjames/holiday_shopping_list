//
//  ItemDetailViewController.swift
//  ChristmasList
//
//  Created by DLM on 11/13/18.
//  Copyright © 2018 DLM. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailViewController: UIViewController, addItemDelegate {
    
    func addButtonPressed() {
        print("hi")
    }
    
    func editButtonPressed(by controller: ItemDetailViewController, with itemName: String, personName: String, categoryDescription: String) {
        print("bye")
    }
    
    func save(item: Item, indexPath: IndexPath?) {
        saveContext()
        itemNameLabel.text = item.name
        desc.text = item.details
        personLabel.text = item.person!.name
        delegate?.save(item: item, indexPath: nil)
        dismiss(animated: true, completion: nil)
    }
    
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var personLabel: UILabel!
    
    @IBOutlet weak var storesLabel: UILabel!
    
    weak var delegate: addItemDelegate?
    
    var currentItem: Item?
    
    var indexPath: IndexPath?
   
    @IBOutlet weak var desc: UILabel!
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func editButtonClicked(_ sender: UIBarButtonItem) {
       performSegue(withIdentifier: "editItem", sender: sender)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editItem"{
            let navCon = segue.destination as! UINavigationController
            let destination = navCon.topViewController as! AddItemViewController
            destination.delegate = self
            destination.currentItem = currentItem
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameLabel.text = currentItem!.name
        desc.text = currentItem!.details
        personLabel.text = currentItem?.person?.name
        //storesLabel.text = currentItem?.stores
    }
    


}

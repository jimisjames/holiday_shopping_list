//
//  ListTableViewController.swift
//  ChristmasList
//
//  Created by DLM on 11/13/18.
//  Copyright © 2018 DLM. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController, addItemDelegate {

    override func viewDidAppear(_ animated: Bool) {

        fetchData()
        tableView.reloadData()
    }
    
    func addStores(){
        let newStore1 = Store(context: managedObjectContext)
        newStore1.name = "Amazon"
        let newStore2 = Store(context: managedObjectContext)
        newStore2.name = "Target"
        let newStore3 = Store(context: managedObjectContext)
        newStore3.name = "Walmart"
        let newStore4 = Store(context: managedObjectContext)
        newStore4.name = "Best Buy"
        saveContext()
        let storeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Store")
        do {
            let results = try managedObjectContext.fetch(storeRequest)
            let stores = results as! [Store]
            print(stores)
        } catch {
            print("\(error)")
        }
    }
   
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    
    func editButtonPressed(by controller: ItemDetailViewController, with itemName: String, personName: String, categoryDescription: String) {
        print("Hello")
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        print("LOGOUT")
        performSegue(withIdentifier: "unwindToFirst", sender: self)
    }
    @IBAction func addNew(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "addItem", sender: sender)
    }
    
    var items = [Item]()
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            let navController = segue.destination as! UINavigationController
            let destination = navController.topViewController as! AddItemViewController
            destination.delegate = self
        }
        else if segue.identifier == "itemDetail" {
            let navController = segue.destination as! UINavigationController
            let destination = navController.topViewController as! ItemDetailViewController
            destination.delegate = self
            destination.currentItem = items[(sender as! IndexPath).row]
            destination.indexPath = sender as! IndexPath
        }
    }
    
    func fetchData(){
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        do {
            let results = try managedObjectContext.fetch(itemRequest)
            items = results as! [Item]
        } catch {
            print("\(error)")
        }
    }
    
    
    
    
    func addButtonPressed(){
        fetchData()
        tableView.reloadData()
    }
    
    func save(item: Item, indexPath: IndexPath?) {
        fetchData()
        tableView.reloadData()
        print("Hello")
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        managedObjectContext.delete(items[indexPath.row])
        saveContext()
        fetchData()
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel!.text = items[indexPath.row].name
        cell.textLabel!.textColor = UIColor.white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "itemDetail", sender: indexPath)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        //addStores()
    }

   

}

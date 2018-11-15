//
//  StoreItemsListTableViewController.swift
//  ChristmasList
//
//  Created by Jim Lambert on 11/14/18.
//  Copyright © 2018 DLM. All rights reserved.
//

import UIKit
import CoreData

class StoreItemsListTableViewController: UITableViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    var store: Store?
    var items: NSArray?

    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = store!.items!.sortedArray(using: [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]) as NSArray
        print(items!)
        //print(items![0])
        //print(type(of: items![0]))
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath)
        cell.textLabel!.text = (items![indexPath.row] as! Item).name
        cell.textLabel?.textColor = UIColor.white
        return cell
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (items?.count)!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = items![indexPath.row] as! Item
        managedObjectContext.delete(item)
        saveContext()
        tableView.reloadData()
    }

}

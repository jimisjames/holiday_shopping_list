//
//  StoresTableViewController.swift
//  ChristmasList
//
//  Created by Jim Lambert on 11/14/18.
//  Copyright © 2018 DLM. All rights reserved.
//

import UIKit
import CoreData

class StoresTableViewController: UITableViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    var stores = [Store]()

    func fetchData(){
        let storeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Store")
        do {
            let results = try managedObjectContext.fetch(storeRequest)
            stores = results as! [Store]
            print(stores)
        } catch {
            print("\(error)")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bob", for: indexPath)
        cell.textLabel!.text = stores[indexPath.row].name
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "items", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navCon = segue.destination as! UINavigationController
        let destination = navCon.topViewController as! StoreItemsListTableViewController
        destination.store = stores[(sender as! IndexPath).row]
    }

}

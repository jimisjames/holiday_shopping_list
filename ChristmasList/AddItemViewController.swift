//
//  AddItemViewController.swift
//  ChristmasList
//
//  Created by DLM on 11/13/18.
//  Copyright © 2018 DLM. All rights reserved.
//

import UIKit
import CoreData

class AddItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBAction func target(_ sender: UISwitch) {
        if sender.isOn == true {
            selectedStores.append(stores[2])
        } else {
            //selectedStores.remove(at: 1)
        }
    }
    @IBAction func bestBuy(_ sender: UISwitch) {
        if sender.isOn == true {
            selectedStores.append(stores[3])
        } else {
            //selectedStores.remove(at: 2)
        }

    }
    @IBAction func walmart(_ sender: UISwitch) {
        if sender.isOn == true {
            selectedStores.append(stores[1])
        } else {
            //selectedStores.remove(at: 0)
        }
    }
    @IBAction func amazon(_ sender: UISwitch) {
        if sender.isOn == true {
            selectedStores.append(stores[0])
        } else {
            //selectedStores.remove(at: 3)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        itemNameField.resignFirstResponder()
        personName.resignFirstResponder()
        descLabel.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Billy")
        cell.textLabel!.text = people[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(people[indexPath.row])
        saveContext()
        fetchData()
        tableView.reloadData()
    }

    weak var delegate: addItemDelegate?
    weak var currentItem: Item?
    
    var people = [Person]()
    var selectedPerson: Person?
    
    var stores = [Store]()
    var selectedStores = [Store]()
    
    @IBOutlet weak var itemNameField: UITextField!
    
    @IBOutlet weak var personName: UITextField!
    
    @IBOutlet weak var personPicker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        //return NSAttributedString(string: people[row].name!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
//        return people[row].name!
//    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = people[row].name!
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return myTitle
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return people.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPerson = people[row]
    }
    
    @IBAction func addPerson(_ sender: UIButton) {
        let newPerson = NSEntityDescription.insertNewObject(forEntityName: "Person", into: managedObjectContext) as! Person
        newPerson.name = personName.text
        saveContext()
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var descLabel: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if let item = currentItem {
            currentItem?.name = itemNameField.text
            currentItem?.details = descLabel.text
            currentItem?.person = selectedPerson
            delegate?.save(item:item, indexPath: nil)
        }
        else {
            if people.count == 0 {
                let alert = UIAlertController(title: "No People to shop for!", message: "Add a person to shop for first!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                let newItem = Item(context: managedObjectContext)
                newItem.name = itemNameField.text
                newItem.details = descLabel.text
                selectedPerson!.addToItems(newItem)
                for x in selectedStores {
                    x.addToItems(newItem)
                }
                saveContext()
                delegate?.addButtonPressed()
                
                dismiss(animated: true, completion: nil)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameField.delegate = self
        personName.delegate = self
        descLabel.delegate = self
        fetchData()
        tableView.isScrollEnabled = true
        if people.count > 0 {
            selectedPerson = people[0]
        }
        if let item = currentItem {
            itemNameField.text = item.name
            descLabel.text = item.details
        }
    }
    
    func fetchData(){
        let personRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try managedObjectContext.fetch(personRequest)
            people = results as! [Person]
        } catch {
            print("\(error)")
        }
        let storeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Store")
        do {
            let results = try managedObjectContext.fetch(storeRequest)
            stores = results as! [Store]
            print(stores)
        } catch {
            print("\(error)")
        }
    }
    
    @IBAction func backButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

   
}

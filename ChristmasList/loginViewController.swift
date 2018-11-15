//
//  ViewController.swift
//  ChristmasList
//
//  Created by DLM on 11/13/18.
//  Copyright © 2018 DLM. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newUserNameField.resignFirstResponder()
        newPasswordField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
        return true
    }

    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginFlash: UILabel!
    
//    @IBAction func logOut(_ sender: UIBarButtonItem) {
//        print("LOGOUT")
//        performSegue(withIdentifier: "unwindToFirst", sender: self)
//    }
    
    @IBAction func unwindToFirst(segue: UIStoryboardSegue){}
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        if userNameField.text!.count > 0 && passwordField.text!.count > 0 {
            
            let url = "http://192.168.1.193:5000/processlog/" + userNameField.text! + "/" + passwordField.text!
            
            let request = URLRequest(url: URL(string: url)!)
            
            let task = URLSession.shared.dataTask(with: request){(data, response, error) in
                if error == nil {
            
                    do{
                        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            print(jsonResult)
                            if jsonResult["success"]! as! Int == 1 {
                    
                                DispatchQueue.main.async {
                                    self.loginFlash.text = ""
                                    self.performSegue(withIdentifier: "loginSegue", sender: "BOB")
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.loginFlash.text = jsonResult["error"]! as! String
                                }
                                print("BLAH")
                            }
                        }
                    } catch {
                        print("Hello")
                        print("Error: \(error)")
                    }
                } else {
                    print("Error: \(error)")
                }
            }
            task.resume()
        } else {
            print("No Entries")
        }
    }
    
    @IBOutlet weak var newUserNameField: UITextField!

    
    @IBOutlet weak var newPasswordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    struct newUserInfo: Codable {
        let username: String
        let password: String
        let password_confirm: String
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        if newUserNameField.text!.count > 0 && newPasswordField.text!.count > 0 && confirmPasswordField.text!.count > 0 {
            
            print(newUserNameField.text!)
            let url = "http://192.168.1.193:5000/processReg/" + newUserNameField.text! + "/" + newPasswordField.text! + "/" + confirmPasswordField.text!
            
            var request = URLRequest(url: URL(string: url)!)
            
            let task = URLSession.shared.dataTask(with: request){(data, response, error) in
                print("***********************")
                if error == nil {
                    do{
                        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            print(jsonResult)
                            if jsonResult["success"]! as! Int == 1 {
                                DispatchQueue.main.async {
                                    self.performSegue(withIdentifier: "loginSegue", sender: "BOB")
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.loginFlash.text = jsonResult["error"]! as! String
                                }
                                print("BLAH")
                            }
                        }
                    } catch {
                        print("Hello")
                        print("Error: \(error)")
                    }
                } else {
                    print("Error: \(error)")
                }
            }
            task.resume()
        } else {
            print("No Entries")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newUserNameField.delegate = self
        newPasswordField.delegate = self
        confirmPasswordField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }


}


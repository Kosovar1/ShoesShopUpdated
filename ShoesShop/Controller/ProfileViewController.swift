//
//  PassingDataViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 10/03/2023.
//
import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
  
 
    @IBOutlet weak var nextPageRadius: UIButton!
    
    
    var name1: String = ""
    var userName1: String = ""
    var fullName1: String = ""
    var email1: String = ""
    
    
    
    var retypePassword: String = ""
    var name: String = ""
    var userName: String = ""
    var fullName: String = ""
    var email: String = ""
    
    override func viewDidLoad() {
            super.viewDidLoad()
            navigationItem.hidesBackButton = true
           
            topLabel.text = "Name: \(name1)"
            fullNameLabel.text = " Username:\(fullName1)"
            userNameLabel.text = "Your email \(email1)"
            theLookof(nextPageRadius)
            
            
            topLabel.text = "For email \(email) password has been reset"
            fullNameLabel.text = "write somewhere this new pasword \(retypePassword)"
            
            
           
        }
    func theLookof(_ input: AnyObject){
        input.layer?.borderColor = UIColor.black.cgColor
        input.layer?.cornerRadius = 5
        input.layer?.borderWidth = 2
    }
    
    @IBAction func LogOutPressed(_ sender: UIBarButtonItem) {
      
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

    



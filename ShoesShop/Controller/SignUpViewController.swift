//
//  SignUpViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 10/03/2023.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var user: User?
 
    
    @IBOutlet weak var theFirstName: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var emailText: UITextField!

    @IBOutlet weak var signInButton: UIButton!
    
  
  
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theLookof(theFirstName)
        theLookof(userTextField)
  
        theLookof(emailText)
        
       
      
        theLookof(signInButton)
    }
  
 
    
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "profileViewController", sender: self)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileViewController" {
            if let vc = segue.destination as? ProfileViewController {
                vc.name = theFirstName.text!
                vc.email = emailText.text!
                vc.fullName = userTextField.text!
                
                
            }
        }
                
    }
            
        }
    
    func theLookof(_ input: AnyObject){
        input.layer?.borderColor = UIColor.black.cgColor
        input.layer?.cornerRadius = 5
        input.layer?.borderWidth = 2
    }
    


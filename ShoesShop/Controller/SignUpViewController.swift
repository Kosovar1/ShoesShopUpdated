//
//  SignUpViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 10/03/2023.
//

import UIKit
import Firebase


class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var user: User?
    
    
    @IBOutlet weak var theFirstName: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var emailRadius: UIButton!
    
    @IBOutlet weak var passwordRadius: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theLookof(theFirstName)
        theLookof(userTextField)
        
        theLookof(emailText)
        theLookof(signInButton)
        theLookof(emailRadius)
        theLookof(passwordRadius)
    }
    
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        
//        performSegue(withIdentifier:"profileViewController", sender: self)
        if let email = emailText.text, let password = passwordRadius.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
              // ...
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "profileViewController", sender: self)
                }
        }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileViewController" {
            if let profileViewController  = segue.destination as? ProfileViewController{
                let user = User(name: theFirstName.text, userName: userTextField.text, email: emailText.text)
                profileViewController.name1 = user.name ?? ""
                profileViewController.userName1 = user.userName ?? ""
                profileViewController.email1 = user.email ?? ""
            }
        }
    }
    func theLookof(_ input: AnyObject){
        input.layer?.borderColor = UIColor.black.cgColor
        input.layer?.cornerRadius = 5
        input.layer?.borderWidth = 2
    }
    
}

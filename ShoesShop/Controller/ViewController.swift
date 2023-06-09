//
//  ViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 11/02/2023.
//

import UIKit
import Firebase
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var user: User?
    var isClicked = true
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var signUpRadius: UIButton!
    
    @IBOutlet weak var forgotRadius: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Welcome💐💐"
        
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = "Welcome 💐💐"
        for letter in titleText {
           
            Timer.scheduledTimer(withTimeInterval: 0.5 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
        
        usernameTextField.delegate = self
        cornerRadius(input: loginButton)
        cornerRadius(input: signUpButton)
        cornerRadius(input: forgotRadius)
   
    }
    

    func cornerRadius(input: AnyObject) {
        input.layer?.cornerRadius = 10
        input.layer?.borderColor = UIColor.black.cgColor
        input.layer?.borderWidth = 2
        input.layer?.shadowRadius = 10
        input.layer?.shadowOpacity = 0.2
    }
    

    @IBAction func logaction(_ sender: Any) {
       
//        if let usernameTextField = self.usernameTextField.text, usernameTextField.isEmpty {
//            let alert = UIAlertController(title: "Alert", message: "Your text field is empty", preferredStyle: .alert)
//            alert.addAction (UIAlertAction(title: "OK", style: .default, handler: nil))
//            present (alert, animated: true, completion: {
//                return
//            })
//        } else
        if let passwordTextField = self.passwordTextField.text, passwordTextField.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Your Password field is empty", preferredStyle: .alert)
            alert.addAction (UIAlertAction(title: "OK", style: .default, handler: nil))
            present (alert, animated: true, completion: {
                return
            })
            return
        }
        if let email = emailText.text, let password = passwordTextField.text {

            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    if let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "goToHome1") as? HomeViewController {
                        
                        let user = User(name: self.usernameTextField.text )
                        
                        homeViewController.name = user.name ?? ""
                        

                        self.navigationController?.pushViewController(homeViewController, animated: true)
                    }
                }
            }
        }
    }
}



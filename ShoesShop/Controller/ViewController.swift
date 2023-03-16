//
//  ViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 11/02/2023.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var user: User?
    var isClicked = true
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        
        
      
        cornerRadius(input: loginButton)
    
   
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
       performSegue(withIdentifier: "goToHome", sender: self)
    }
    
    
    func cornerRadius(input: AnyObject) {
        input.layer?.cornerRadius = 10
        input.layer?.borderColor = UIColor.black.cgColor
        input.layer?.borderWidth = 2
        input.layer?.shadowRadius = 10
        input.layer?.shadowOpacity = 0.2
    }
    

    
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHome" {
            if let homeViewController = segue.destination as? HomeViewController{
                let user = User(userName: usernameTextField.text)
                homeViewController.showUsername = user.userName ?? ""
                
            }
        }
    }

}

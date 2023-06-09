//
//  ForgotPaswordViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 10/03/2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var changePassword: UITextField!
  
    @IBOutlet weak var retypePasswordField: UITextField!
    
    @IBOutlet weak var submitRadius: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        changeCornerRad(submitRadius)
        changeCornerRad(emailTextField)
        changeCornerRad(changePassword)
        changeCornerRad(retypePasswordField)
    }
    func changeCornerRad(_ input: AnyObject) {
        input.layer?.cornerRadius = 8
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        performSegue(withIdentifier:"goToProfile", sender: self)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfile" {
            if let profileViewController  = segue.destination as? ProfileViewController {
                let user = User(email: emailTextField.text, pasword: changePassword.text, retypePassword: retypePasswordField.text)
                profileViewController.email = user.email ?? ""
                profileViewController.retypePassword = user.retypePassword ?? ""
                
            }
        }
    }
  
}
    
    

    
  
    
  



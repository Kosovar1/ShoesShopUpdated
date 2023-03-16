//
//  PassingDataViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 10/03/2023.
//
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
  
 
    @IBOutlet weak var nextPageRadius: UIButton!
    
    
    
    
    
    var firstLabel: String = ""
    var name: String = ""
    var userName: String = ""
    var fullName: String = ""
    var email: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.text = "Name: \(name)"
        fullNameLabel.text = "Username: \(fullName)"
        userNameLabel.text = "Your email \(email)"
        theLookof(nextPageRadius)
        topLabel.text = "For email \(email) password has been reset"
        
       
    }
    func theLookof(_ input: AnyObject){
        input.layer?.borderColor = UIColor.black.cgColor
        input.layer?.cornerRadius = 5
        input.layer?.borderWidth = 2
    }
}

    



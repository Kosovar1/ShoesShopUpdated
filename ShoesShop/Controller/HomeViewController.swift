//
//  LoginHomeViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 10/03/2023.
//

import UIKit


class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var firstLabel: UILabel!
    
 
    @IBOutlet weak var largImage: UIImageView!
  
    
    var showUsername: String = "in this app,"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RadiusChange(input: largImage)
        RadiusChange(input: firstLabel)
        
        firstLabel.text = "Welcome \(showUsername) you will spend all of your money in this shoes!"
        
    }
  
    
    
    func RadiusChange(input: AnyObject){
        input.layer?.cornerRadius = 5
        input.layer?.shadowRadius = 1
        input.layer?.shadowOpacity = 0.2
    }
    
   


}

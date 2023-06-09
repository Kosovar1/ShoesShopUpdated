//
//  LoginHomeViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 10/03/2023.
//

import UIKit


class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var informationButton: UIButton!
    
    @IBOutlet weak var FindUsButton: UIButton!
    
    @IBOutlet weak var chatButton: UIButton!
    
    
    @IBOutlet weak var playShoesButton: UIButton!
    
    
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RadiusChange(input: playShoesButton)
        RadiusChange(input: FindUsButton)
        RadiusChange(input: chatButton)
       RadiusChange(input: informationButton)
        RadiusChange(input: firstLabel)
        
        firstLabel.text = "Welcome, \(name) you will spend all of your money in this beautiful shoes Application!\n This App is more about friendship, you can have a chat with your friend talking about shoes, you will find links of brands, find some models to talk about, play together and many more things you can do!\n "
        
        
    }
  
    func RadiusChange(input: AnyObject){
        input.layer?.cornerRadius = 5
        input.layer?.shadowRadius = 1
        input.layer?.shadowOpacity = 0.2
    }
    
    @IBAction func informationButtonPressed(_ sender: Any) {
//        performSegue(withIdentifier:"InformationViewController", sender: self)
               }
    @IBAction func findUsButtonPressed(_ sender: Any) {
        
//        performSegue(withIdentifier:"MapViewController", sender: self)
    }
        
    
    
    @IBAction func playShoesButtonPressed(_ sender: Any) {
//        performSegue(withIdentifier:"GestureViewController", sender: self)
    }
    
    @IBAction func chatButtonPressed(_ sender: Any) {
//        performSegue(withIdentifier:"ChatViewController", sender: self)
    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//          if let identifier = segue.identifier {
//              if identifier == "InformationSegue" {
//                  // Handle the "Information" button segue
//                  if let destinationVC = segue.destination as? InformationViewController {
//                      // Set the property or pass any necessary data to the destination view controller
//                      // destinationVC.property = value
//                  }
//              } else if identifier == "FindUsSegue" {
//                  // Handle the "Find Us" button segue
//                  if let destinationVC = segue.destination as? MapViewController {
//                      // Set the property or pass any necessary data to the destination view controller
//                      // destinationVC.property = value
//                  }
//              } else if identifier == "PlayShoesSegue" {
//                  // Handle the "Play Shoes" button segue
//                  if let destinationVC = segue.destination as? GestureViewController {
//                      // Set the property or pass any necessary data to the destination view controller
//                      // destinationVC.property = value
//                  }
//              } else if identifier == "ChatSegue" {
//                  // Handle the "Chat" button segue
//                  if let destinationVC = segue.destination as? ChatViewController {
//                      // Set the property or pass any necessary data to the destination view controller
//                      // destinationVC.property = value
//                  }
//              }
//          }
//      }
}

//
//  ChatViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 22/04/2023.
//

import UIKit
import Firebase
import Foundation

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    let db = Firestore.firestore()
    
    var messages: [Message] = []
 
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell1")
        
        loadMessages()
        
    }
    func loadMessages() {
      
        
        db.collection(FStore.collectionName)
            .order(by: FStore.dataField)
            .addSnapshotListener { (querySnapshot , error) in
            
            self.messages = []
            
            if let e = error {
                print("There was an issue retrieving data from Firestore . \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[FStore.senderField] as? String, let messageBody = data[FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                           
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                
                                // duhet me bo me minus per me ardh mesazhi i fundit
                                
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
        }
        }
    }



}
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell1", for: indexPath) as! MessageCell
        cell.label.text = message.body
        //this is a message from the current user.
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBuble.backgroundColor = UIColor(named: BrandColors.fourNumber)
            cell.label.textColor = UIColor(named: BrandColors.oneNumber)
        }
    //this is a message from another sender.
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBuble.backgroundColor = UIColor(named: BrandColors.threeNumber)
            cell.label.textColor = UIColor(named: BrandColors.twoNumber)
        }
        return cell
        
        
    }
    @IBAction func sendPressed( _ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
               db.collection(FStore.collectionName).addDocument(data: [
                   FStore.senderField: messageSender,
                   FStore.bodyField: messageBody,
                   FStore.dataField: Date().timeIntervalSince1970
               ]) { [weak self] (error) in
                   guard let self = self else { return }
                   
                   if let e = error {
                       print("There was an issue saving data, \(e)")
                   } else {
                       print("Successfully saved data.")
                       self.triggerNotification(messageBody: messageBody)
                       
                       DispatchQueue.main.async {
                           self.messageTextField.text = ""
                       }
                   }
               }
           }
       }
    func triggerNotification(messageBody: String) {
        let content = UNMutableNotificationContent()
        content.title = "New Message"
        content.body = messageBody
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false) // Trigger the notification immediately
        
        let request = UNNotificationRequest(identifier: "NewMessageNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Failed to add notification request: \(error)")
            }
        }
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

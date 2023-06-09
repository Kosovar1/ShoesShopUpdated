//
//  MessageCell.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 22/04/2023.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBuble: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBuble.layer.cornerRadius = messageBuble.frame.size.height / 5
        
        leftImageView.layer.cornerRadius = leftImageView.frame.height / 2
        leftImageView.clipsToBounds = true
        rightImageView.layer.cornerRadius = leftImageView.frame.height / 2
        rightImageView.clipsToBounds = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

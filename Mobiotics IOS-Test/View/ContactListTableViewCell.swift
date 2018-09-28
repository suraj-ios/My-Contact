//
//  ContactListTableViewCell.swift
//  Mobiotics IOS-Test
//
//  Created by Suraj on 28/09/18.
//  Copyright © 2018 Suraj. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {

    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contactImage.layer.cornerRadius = contactImage.frame.height/2
        
        contactImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  ContactCell.swift
//  Login
//
//  Created by Danielle Nunez on 12/3/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var icon: UIImageView!
    
    var name: String?
    var character_class: String? {
        didSet {
            if let character_class = character_class {
                icon.image = UIImage(named: character_class)
                icon.contentMode = .scaleAspectFit
            }
        }
    }
}


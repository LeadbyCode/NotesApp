//
//  NotesTableViewCell.swift
//  Demo Task By Sarvesh
//
//  Created by Nilesh Vernekar on 11/04/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var Lbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
      static let cellIdentifier = "NotesTableViewCell"
         static let xibName = "NotesTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

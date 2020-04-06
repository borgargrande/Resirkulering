//
//  ProduktViewTableViewCell.swift
//  Resirkulering
//
//  Created by Borgar Grande on 31/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import UIKit

class ProduktViewTableViewCell: UITableViewCell {

    @IBOutlet weak var produktNameOutlet: UILabel!
    @IBOutlet weak var selectedOutlet: UISwitch!
    
    @IBOutlet weak var buttonOutlet: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}

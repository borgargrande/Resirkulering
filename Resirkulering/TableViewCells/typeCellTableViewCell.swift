//
//  typeCellTableViewCell.swift
//  Resirkulering
//
//  Created by Borgar Grande on 20/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import UIKit

class typeCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var selectAllButtonOutlet: UISwitch!
    @IBOutlet weak var typeLabelOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    @IBAction func selectAllPushed(_ sender: Any) {
        print("Selected all pushed " + typeLabelOutlet.text!)
    }


}

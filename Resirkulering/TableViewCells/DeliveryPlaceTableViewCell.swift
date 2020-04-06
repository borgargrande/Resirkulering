//
//  DeliveryPlaceTableViewCell.swift
//  Resirkulering
//
//  Created by Borgar Grande on 01/04/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import UIKit

class DeliveryPlaceTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var placeNameOutlet: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

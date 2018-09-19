//
//  ProgramaTableViewCell.swift
//  IMCorrs
//
//  Created by Community Manager on 18/09/18.
//  Copyright © 2018 Expodiseno. All rights reserved.
//

import UIKit

class ProgramaTableViewCell: UITableViewCell {
    @IBOutlet weak var lblHorario: UILabel!
    
    @IBOutlet weak var lblDescripcion: UILabel!
    
    @IBOutlet weak var lblAutores: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ResultTableViewCell.swift
//  Go Ask A Duck
//
//  Created by MouseHouseApp on 2/19/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var result: UILabel!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

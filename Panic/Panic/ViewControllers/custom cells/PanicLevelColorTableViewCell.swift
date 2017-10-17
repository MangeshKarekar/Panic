//
//  PanicLevelColorTableViewCell.swift
//  Panic
//
//  Created by Mangesh Karekar on 16/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit
import RealmSwift

class PanicLevelColorTableViewCell: UITableViewCell {
    
    var colorEntity: ColorsEntity?{
        didSet{
            setBackgroundColor(color: colorEntity?.color)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setBackgroundColor(color: UIColor?){
        self.backgroundColor = color
    }
 
}

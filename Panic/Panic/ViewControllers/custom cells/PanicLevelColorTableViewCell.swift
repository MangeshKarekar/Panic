//
//  PanicLevelColorTableViewCell.swift
//  Panic
//
//  Created by Mangesh Karekar on 16/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit


class PanicLevelColorTableViewCell: UITableViewCell {

    var panicColor: PanicColor?{
        didSet{
            setColor(panicColor: panicColor)
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

    private func setColor(panicColor: PanicColor?){
        if let panicColor = panicColor{
            switch panicColor{
            case .red: self.backgroundColor = Colors.panicRed
            case .yellow: self.backgroundColor = Colors.panicYellow
            case .green: self.backgroundColor = Colors.panicGreen
            }
        }
    }
}

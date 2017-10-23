//
//  CustomButtons.swift
//  Panic
//
//  Created by Mangesh Karekar on 23/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import UIKit

class CurvedButton: UIButton {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 5.0
        layer.borderWidth = 1.0
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

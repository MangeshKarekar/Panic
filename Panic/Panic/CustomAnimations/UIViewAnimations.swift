//
//  UIViewAnimations.swift
//  Panic
//
//  Created by Mangesh Karekar on 12/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import UIKit

class UIViewAnimations {
    static func shrink(view: UIView){
        UIView.animate(withDuration: 0.25, animations: {
            view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { (finished) in
            UIView.animate(withDuration: 0.25, animations: {
                view.transform = CGAffineTransform.identity
            })
        }
    }
    
    
    static func expand(view: UIView){
        
        UIView.animate(withDuration: 1, animations: {
            view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { (finished) in
            UIView.animate(withDuration: 1, animations: {
                view.transform = CGAffineTransform.identity
            })
        }
    }
}

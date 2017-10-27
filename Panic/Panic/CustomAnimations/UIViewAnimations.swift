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
    
    static func showFlash(withMessage message: String, backgroundColor: UIColor?, inView view: UIView){
        let flashView = UIView(frame: view.frame)
        flashView.backgroundColor = Colors.panicRed
        if let backgroundColor = backgroundColor{
            flashView.backgroundColor = backgroundColor
        }
        flashView.alpha = 0.0
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: flashView.frame.width, height: 40))
        label.center = flashView.center
        label.textAlignment = NSTextAlignment.center
        label.text = message
        label.textColor = UIColor.white
        flashView.addSubview(label)
        view.addSubview(flashView)
        UIView.animate(withDuration: 1.0, animations: {
            flashView.alpha = 1.0
        }) { (finished) in
            UIView.animate(withDuration: 1.0, animations: {
                flashView.alpha = 0.0
                flashView.removeFromSuperview()
            })
        }
    }
}

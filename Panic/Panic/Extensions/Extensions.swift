//
//  Extensions.swift
//  Panic
//
//  Created by Mangesh Karekar on 16/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    func colorFromHex(alpha: CGFloat? = 1.0)-> UIColor{
        let hexint = Int(colorInteger(fromHexString: self))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha!)
        return color
    }
    
    func colorInteger(fromHexString: String) -> UInt32 {
        var hexInt: UInt32 = 0
        let scanner: Scanner = Scanner(string: fromHexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}

extension UIColor{
    
    func panicRed()->UIColor{
        let redHex = "FA2E31"
        return redHex.colorFromHex(alpha: 1.0)
    }
    
    func panicGreen()->UIColor{
        let greenHex = "A2D345"
        return greenHex.colorFromHex(alpha: 1.0)
    }
    
    func panicYellow()->UIColor{
        let yellowHex = "FFD501"
        return yellowHex.colorFromHex(alpha: 1.0)
    }
}

extension UIAlertController{

   class func showErrorAlert(withMessage message:String ,inView view: UIViewController){
        let alert = UIAlertController(title: "Error", message:message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        view.present(alert, animated: true, completion: nil)
    }
}

extension UIActivityIndicatorView{
    
   class func getActivity(withStyle style: UIActivityIndicatorViewStyle) ->UIActivityIndicatorView{
        let activity = UIActivityIndicatorView(activityIndicatorStyle: style)
        activity.hidesWhenStopped = true
        return activity
    }
    
}

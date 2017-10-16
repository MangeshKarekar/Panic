//
//  ContactsViewController.swift
//  Panic
//
//  Created by Mangesh Karekar on 16/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    var colorTheme: PanicColor?
    
    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground() 
        // Do any additional setup after loading the view.
    }
    
    func setBackground(){
        if let colorTheme = colorTheme{
            switch colorTheme{
            case .red: backgroundView.backgroundColor = Colors.panicRedWithAlpha(alpha: 0.3)
            case .yellow: backgroundView.backgroundColor = Colors.panicYellowWithAlpha(alpha: 0.3)
            case .green: backgroundView.backgroundColor = Colors.panicGreenWithAlpha(alpha: 0.3)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

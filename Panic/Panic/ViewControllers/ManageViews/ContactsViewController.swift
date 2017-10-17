//
//  ContactsViewController.swift
//  Panic
//
//  Created by Mangesh Karekar on 16/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit
import RealmSwift

class ContactsViewController: UIViewController {
    
    var colorEntity: ColorsEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let colorEntity = colorEntity{
            setUI(forEntity: colorEntity)
        }
        // Do any additional setup after loading the view.
    }
    
    func setUI(forEntity colorEntity: ColorsEntity){
        self.view.backgroundColor = colorEntity.color
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
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

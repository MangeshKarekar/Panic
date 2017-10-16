//
//  ManageViewController.swift
//  Panic
//
//  Created by Mangesh Karekar on 13/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit
import ContactsUI

class ManageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CNContactPickerDelegate {

    private let paniCellID = "panicColorCell"
    private let panicColors = ["Red": Colors.panicRed, "Yellow":Colors.panicYellow, "Green ": Colors.panicGreen]
    private var panicColorKeys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panicColorKeys = [String](panicColors.keys)
        // Do any additional setup after loading the view.
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
    
    
    
    //MARK: Tabale view datasource & delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return panicColors.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return panicColorKeys[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: paniCellID) as! PanicLevelColorTableViewCell
        cell.panicColor = getColorForSections(index: indexPath.section)
        return cell
    }
    
    private func getColorForSections(index:Int)-> PanicColor?{
        switch index {
        case 0:return PanicColor.red
        case 1: return PanicColor.yellow
        case 2: return PanicColor.green
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    @IBAction func pressed(_ sender: UIButton){
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]){
        
        print(contacts)
    }


}

//
//  ContactsViewController.swift
//  Panic
//
//  Created by Mangesh Karekar on 16/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit
import RealmSwift

class ContactsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,UITextViewDelegate {
    
    var colorEntity: ColorsEntity?
    var contacts =  List<ContactsEntity>()
    var color: Color?
    
    let tableSections = 3
    let tableviewRows = 1
    
    let locationCellID = "LocationCell"
    let messageCellID = "MessageCell"
    let contactsCellID = "ContactsCell"
    
    @IBOutlet weak var manageTable: UITableView!
    @IBOutlet weak var locationSwitch: UISwitch!
    
    @IBOutlet weak var messageTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let colorEntity = colorEntity{
            
            setUI(forEntity: colorEntity)
        }
        // Do any additional setup after loading the view.
    }
    
    func setUI(forEntity colorEntity: ColorsEntity){
        self.view.backgroundColor = colorEntity.color
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(blurEffectView)
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
    
    //MARK: UItableview datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section{
        case 0: return "Location services"
        case 1: return "Type your Panic message here"
        case 2: return "Your Panic Contacts"
        default : return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0: return tableviewRows
        case 1: return tableviewRows
        case 2: return contacts.count
        default : return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0: return getLocationCell(tableView)
        case 1: return getMessageCell(tableView)
        case 2: return getContactCellFor(indexPath.row)
        default : return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section{
        case 0: return 55
        case 1: return 162
        case 2: return 55
        default : return 55
        }
        
    }
    
    func getLocationCell(_ tableView: UITableView )-> LocationTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: locationCellID) as! LocationTableViewCell
        return cell
    }
    
    func getMessageCell(_ tableView: UITableView )-> MessageTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: messageCellID) as! MessageTableViewCell
        return cell
    }
    
    func getContactCellFor(_ index: Int) -> UITableViewCell{
        let cell = manageTable.dequeueReusableCell(withIdentifier: contactsCellID)
        cell?.textLabel?.text = contacts[index].name
        cell?.detailTextLabel?.text = contacts[index].contact.first?.number
        return cell!
    }
    
    //MARK: Textview delegates
    
    
    
    @IBAction func locatonSwitchTapped(_ sender: Any) {
        
    }
}

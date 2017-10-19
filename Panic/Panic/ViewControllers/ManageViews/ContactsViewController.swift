//
//  ContactsViewController.swift
//  Panic
//
//  Created by Mangesh Karekar on 16/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit
import RealmSwift
import ContactsUI

class ContactsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,CNContactPickerDelegate,MessageTableViewCellDelegate {
    
    var colorEntity: ColorsEntity?
    var contacts =  List<ContactsEntity>()
    var color: Color?
    
    let tableSections = 3
    let tableviewRows = 1
    
    let locationCellID = "LocationCell"
    let messageCellID = "MessageCell"
    let contactsCellID = "ContactsCell"
    
    let locationSection = 0
    let messageSection = 1
    let contactSection = 2
    
    let manageController = ManageController.sharedInstance
    
    @IBOutlet weak var manageTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let colorEntity = colorEntity{
            setUI(forEntity: colorEntity)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        do{
            try manageController.saveColor(color: color!)
        }catch{}
    }
    
    func setUI(forEntity colorEntity: ColorsEntity){
      //  self.view.backgroundColor = colorEntity.color
        color = Color(colorEntity: colorEntity)
        self.navigationController?.navigationBar.barTintColor = color!.color
        contacts = color!.contacts
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
        case locationSection: return "Location services"
        case messageSection: return "Type your Panic message here"
        case contactSection: return "Your Panic Contacts"
        default : return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case locationSection: return tableviewRows
        case messageSection: return tableviewRows
        case contactSection: return contacts.count
        default : return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case locationSection: return getLocationCell(tableView)
        case messageSection: return getMessageCell(tableView)
        case contactSection: return getContactCellFor(indexPath.row)
        default : return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case locationSection: return 55
        case messageSection: return 162
        case contactSection: return 55
        default : return 55
        }
    }
    
    func getLocationCell(_ tableView: UITableView )-> LocationTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: locationCellID) as! LocationTableViewCell
        cell.locationSwitch.isOn = color!.locationStatus
        return cell
    }
    
    func getMessageCell(_ tableView: UITableView )-> MessageTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: messageCellID) as! MessageTableViewCell
        cell.delegate = self
        cell.messageText.text = color?.message
        return cell
    }
    
    func getContactCellFor(_ index: Int) -> UITableViewCell{
        let cell = manageTable.dequeueReusableCell(withIdentifier: contactsCellID)
        cell?.textLabel?.text = contacts[index].name
        cell?.detailTextLabel?.text = contacts[index].phones.first?.number
        return cell!
    }
    
    @IBAction func addContactsPressed(_ sender: UIButton){
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        present(contactPicker, animated: true, completion: nil)
    }
    
    @IBAction func locatonSwitchTapped(_ sender: UISwitch) {
        color?.locationStatus = sender.isOn
        let contactIndex = IndexSet(integer: locationSection)
        manageTable.reloadSections(contactIndex, with: .automatic)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        do{
            try manageController.saveColor(color: color!)
            showSuccess(withMessage: "Saved")
        }catch{
            showError(withMessage: "could not save. Please try again")
        }
    }
    
    //MARK: contact UI delegate
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]){
        if contacts.count == 0{
            showError(withMessage: "No Contacts Selected")
        }else{
            addContacts(cnContacts: contacts)
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact){
        addContacts(cnContacts: [contact])
    }
    
    func addContacts(cnContacts: [CNContact]){
        let activityIndicator = UIActivityIndicatorView.getActivity(withStyle: .gray)
        activityIndicator.startAnimating()
        manageController.getContacts(cnContacts: cnContacts) {[weak self] (contacts) in
            self?.contacts = contacts
            self?.color!.contacts = contacts
            DispatchQueue.main.async {[weak self] in
                activityIndicator.stopAnimating()
                let contactIndex = IndexSet(integer: (self?.contactSection)!)
                self?.manageTable.reloadSections(contactIndex, with: .automatic)

            }
        }
    }
    
    func MessageTableViewCell(_ message: String) {
        color!.message = message
    }
    
    private func showError(withMessage message: String){
        UIAlertController.showErrorAlert(withMessage: message, inView: self)
    }

    private func showSuccess(withMessage message: String){
        UIAlertController.showSuccessAlert(withMessage: message, inView: self)
    }

  
}

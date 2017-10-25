//
//  ManageViewController.swift
//  Panic
//
//  Created by Mangesh Karekar on 13/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit
import ContactsUI
import RealmSwift

class ManageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    private let paniCellID = "panicColorCell"
    private let panicColors = ["Red": Colors.panicRed, "Yellow":Colors.panicYellow, "Green ": Colors.panicGreen]
    private var panicColorKeys = [String]()
    private let contactsSegue = "contactsSegue"
    
    let manageController = ManageController.sharedInstance
    var colorResults: Results<ColorsEntity>?
    var theme: ThemeEntity?
    let themeController = ThemeController.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            colorResults = try manageController.getColors()
            theme = try themeController.getTheme()
            setTheme()

        }catch{print(error)}
        panicColorKeys = [String](panicColors.keys)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setTheme()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTheme(){
        if let theme = theme{
            self.view.backgroundColor = theme.themeColor
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == contactsSegue{
            let contactsViewController = segue.destination as! ContactsViewController
            contactsViewController.colorEntity = sender as? ColorsEntity
        }
        
    }
    
    
    
    
    //MARK: Tabale view datasource & delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let colorResults = colorResults{
            return colorResults.count
        }
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: paniCellID) as! PanicLevelColorTableViewCell
        if let colorResults = colorResults{
            cell.colorEntity = colorResults[indexPath.section]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: contactsSegue, sender: colorResults?[indexPath.section])
    }

}

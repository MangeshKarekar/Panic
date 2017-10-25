//
//  SettingsViewController.swift
//  Panic
//
//  Created by Mangesh Karekar on 13/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit
import RealmSwift
class SettingsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var settingsTable: UITableView!
    
    let data = [0: "Themes", 1: "Automatic dark mode"]
    
    let themeController = ThemeController.sharedInstance
    
    var theme: ThemeEntity?
    var darkModeObserver : NotificationToken?
    
    let themeErrorMessage = "Something went wrong please restart the app again"
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            theme = try themeController.getTheme()
        }catch{
            showError(withMessage: themeErrorMessage)
        }
        observeThemeMode()
        // Do any additional setup after loading the view.
    }
    
    func observeThemeMode(){
        darkModeObserver = theme?.observe({[weak self] change in
            
            switch change{
            case .change(_): self?.settingsTable.reloadSections([1], with: .automatic)
            default: break
            }
            
        })
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
    
    //MARK: Tableview datasource & methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCell(forSection: indexPath.section)
        //cell?.textLabel?.text = data[indexPath.section]
        return cell
    }
    
    func getCell(forSection section: Int) ->UITableViewCell{
        let cell = settingsTable.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[section]
        switch section {
        case 0:
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        case 1:
            if let theme = theme{
                if theme.autoDarkMode{
                    cell.accessoryType = UITableViewCellAccessoryType.checkmark
                }
            }
        default: break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section{
        case 0: break
        case 1: toggleAutoDarkMode()
        default: break
        }
    }
    
    //MARK: Functions
    
    func toggleAutoDarkMode(){
        do{
            if let theme = theme{
                try themeController.updateTheme(theme, withDarkMode: !theme.autoDarkMode)
            }
        }catch{
            showError(withMessage: "Could not update your preference")
        }
    }
    
    //MARK: Alerts
    
    private func showError(withMessage message: String){
        UIAlertController.showErrorAlert(withMessage: message, inView: self)
    }
    
}

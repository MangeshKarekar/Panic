//
//  ThemeViewController.swift
//  Panic
//
//  Created by Mangesh Karekar on 25/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit
import RealmSwift

class ThemeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let colorCodes = [ColorCode.dark.rawValue,ColorCode.light.rawValue]
    var theme: ThemeEntity?
    var themeObserver : NotificationToken?
    
    let buttonCodes = [ButtonCode.adult.rawValue,ButtonCode.kids.rawValue]

    let sectionTitles = ["BackgroundColor","Buttons Indication"]
    
    @IBOutlet weak var themeTable: UITableView!

    let themeController = ThemeController.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            theme = try themeController.getTheme()
        }catch{
           // showError(withMessage: themeErrorMessage)
        }
        observeTheme()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func observeTheme(){
        themeObserver = theme?.observe({[weak self] change in
            
            switch change{
            case .change(_): self?.themeTable.reloadSections([0,1], with: .automatic)
            default: break
            }
            
        })
    }
    
    deinit {
        themeObserver?.invalidate()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            return getColorCodeCell(forRow: indexPath.row)

        }else{
            return getButtonCodeCell(forRow: indexPath.row)
        }
        
    }
    
    func getColorCodeCell(forRow row: Int) ->UITableViewCell{
        let cell = themeTable.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = colorCodes[row]
        if let theme = theme{
            if theme.themeColorCode == colorCodes[row]{
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }else{
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
            
        }
        return cell
    }
    
    func getButtonCodeCell(forRow row: Int) ->UITableViewCell{
        let cell = themeTable.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = buttonCodes[row]
        if let theme = theme{
            if theme.homeButtonCode == buttonCodes[row]{
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }else{
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
            
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       updateTheme(for: indexPath)
    }

    func updateTheme(for indexPath: IndexPath){
        do{
            if let theme = theme{
                switch indexPath.section{
                case 0: try themeController.updateTheme(theme, withColorCode: colorCodes[indexPath.row])
                case 1: try themeController.updateTheme(theme, withButtonCode: buttonCodes[indexPath.row])
                default: break
                }
            }
        }catch{
            // to do
        }
    }
    
}

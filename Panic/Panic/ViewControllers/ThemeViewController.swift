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
    var selectedColor = ColorCode.light.rawValue
    let buttonCodes = [ButtonCode.adult.rawValue,ButtonCode.kids.rawValue]

    let sectionTitles = ["Background Color","Buttons Indication"]
    
    @IBOutlet weak var themeTable: UITableView!

    let themeController = ThemeController.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            theme = try themeController.getTheme()
            setTheme()
        }catch{
           // showError(withMessage: themeErrorMessage)
        }
        observeTheme()
        // Do any additional setup after loading the view.
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
            selectedColor = theme.themeColorCode
        }
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
        var cell = UITableViewCell()
        if indexPath.section == 0{
            cell = getColorCodeCell(forRow: indexPath.row)

        }else{
            cell = getButtonCodeCell(forRow: indexPath.row)
        }
        
        if selectedColor == ColorCode.dark.rawValue{
            cell.textLabel?.textColor = UIColor.white
        }else{
            cell.textLabel?.textColor = UIColor.black
        }
        
        return cell
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       updateTheme(for: indexPath)
    }

    func updateTheme(for indexPath: IndexPath){
        do{
            if let theme = theme{
                selectedColor = colorCodes[indexPath.row]
                switch indexPath.section{
                case 0: try themeController.updateTheme(theme, withColorCode: colorCodes[indexPath.row])
                case 1: try themeController.updateTheme(theme, withButtonCode: buttonCodes[indexPath.row])
                default: break
                }
                setTheme()
            }
        }catch{
            // to do
        }
    }
    
}

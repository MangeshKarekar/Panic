//
//  RootViewController.swift
//  Panic
//
//  Created by Mangesh Karekar on 13/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit

class RootViewController: UIViewController,UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController?
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let manageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManageViewController") as! ManageViewController
    let homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    let settingsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
    
    var viewArray = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewArray = [manageViewController,homeViewController,settingsViewController]
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController!.dataSource = self
        let viewControllers = [homeViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })

        self.addChildViewController(self.pageViewController!)
        self.pageViewController!.view.frame = self.view.frame
        self.view.addSubview(self.pageViewController!.view)
        self.pageViewController!.didMove(toParentViewController: self)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func indexofViewController(viewController: UIViewController )->Int?{
        let index = viewArray.index(of: viewController)
        return index
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        if let index = indexofViewController(viewController: viewController){
            if (index == 0){
                return nil
            }
            let newIndex = index-1
            return viewArray[newIndex]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        if let index = indexofViewController(viewController: viewController){
            let newIndex = index+1
            if newIndex == viewArray.count {
                return nil
            }
            return viewArray[newIndex]
        }
        return nil
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

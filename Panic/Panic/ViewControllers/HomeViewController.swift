//
//  ViewController.swift
//  Panic
//
//  Created by Mangesh Karekar on 12/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit
import MessageUI

class HomeViewController: UIViewController,MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var redView: CircleView!
    @IBOutlet weak var yellowView: CircleView!
    @IBOutlet weak var greenView: CircleView!

    let manageController = ManageController.sharedInstance
    var colors: (red: Color?, yellow: Color?, green: Color?)?
        
    let messageServiceNotAvailable = "SMS services are not available"
    
    let noContactsMessage = "No contacts added. Please add them first"
    let generalError = "Something went wrong. Please restart the app again"
    let messageSent = "Message sent"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI(){
        animateViews()
        createColors()
        setupSmsService()
        do{
            colors = try manageController.getColorsTuple()
        }catch{}
    }
    
    func setupSmsService(){
        if !MFMessageComposeViewController.canSendText(){
            UIAlertController.showErrorAlert(withMessage: messageServiceNotAvailable, inView: self)
        }
    }

    func createColors(){
        do{
            try manageController.createColors()
        }catch{}
    }

    func animateViews(){
        UIViewAnimations.shrink(view: redView)
        UIViewAnimations.shrink(view: yellowView)
        UIViewAnimations.shrink(view: greenView)
    }
    
    @IBAction func panicButtonTapped(_ sender: UIButton){
        
        guard let colors = colors else{
            showError(withMessage: generalError)
            return
        }
        
        switch sender.tag {
        case 1:
            if let color = colors.red {
                performAction(forColor: color)
            }else{
                showError(withMessage: generalError)
            }
        case 2:
            if let color = colors.yellow {
                performAction(forColor: color)
            }else{
                showError(withMessage: generalError)
            }
        case 3:
            if let color = colors.green {
                performAction(forColor: color)
            }else{
                showError(withMessage: generalError)
            }
        default:
            showError(withMessage: generalError)
        }
        
    }
    
    func performAction(forColor color: Color){
        var receipients = [String]()
        
        for contact in color.contacts{
            for phone in contact.phones{
                receipients.append(phone.number)
            }
        }
        
        if receipients.count == 0{
            showError(withMessage: noContactsMessage)
            return
        }
        let messageVC = MFMessageComposeViewController()
        messageVC.messageComposeDelegate = self
        messageVC.recipients = receipients
        messageVC.body = color.message
        self.present(messageVC, animated: true, completion: nil)
    }
    
    //MARK: Message delegate
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult){
        controller.dismiss(animated: true) {[weak self] in
            if result == .sent{
                self?.showMessageSentAlert()
            }
        }
    }
    
    func showMessageSentAlert(){
        showSuccess(withMessage: messageSent)
    }
    
    //MARK: Alerts
    
    private func showError(withMessage message: String){
        UIAlertController.showErrorAlert(withMessage: message, inView: self)
    }
    
    private func showSuccess(withMessage message: String){
        UIAlertController.showSuccessAlert(withMessage: message, inView: self)
    }
}


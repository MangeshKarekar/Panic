//
//  ViewController.swift
//  Panic
//
//  Created by Mangesh Karekar on 12/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit
import MessageUI
import CoreLocation

class HomeViewController: UIViewController,MFMessageComposeViewControllerDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var redView: CircleView!
    @IBOutlet weak var yellowView: CircleView!
    @IBOutlet weak var greenView: CircleView!
    
    let manageController = ManageController.sharedInstance
    var colors: (red: Color?, yellow: Color?, green: Color?)?
    var selectedColor: Color?
    let messageServiceNotAvailable = "SMS services are not available"
    
    let noContactsMessage = "No contacts added. Please add them first"
    let generalError = "Something went wrong. Please restart the app again"
    let messageSent = "Message sent"
    
    let locationManager = CLLocationManager()
    
    typealias coordinates = (lattitude: String, longitude: String)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupLocationServices()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        do{
            colors = try manageController.getColorsTuple()
        }catch{}
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLocationServices(){
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        default: break
        }
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
            selectedColor = colors.red
            getUserLocation()
        case 2:
            selectedColor = colors.yellow
            getUserLocation()
        case 3:
            selectedColor = colors.green
            getUserLocation()
        default:
            showError(withMessage: generalError)
        }
        
    }
    
    //MARK: Location functions
    
    func getUserLocation(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways,.authorizedWhenInUse:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()
        default: performActionWith(nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location{
            locationManager.stopUpdatingLocation()
            let coordinates = (lattitude: "\(location.coordinate.latitude)", longitude: "\(location.coordinate.longitude)")
            performActionWith(coordinates)
        }else{
            performActionWith(nil)
        }
    }
    
    func performActionWith(_ userLocation: coordinates?){
        
        if !MFMessageComposeViewController.canSendText(){
            UIAlertController.showErrorAlert(withMessage: messageServiceNotAvailable, inView: self)
            return
        }
        
        
        guard let selectedColor = selectedColor else{
            showError(withMessage: generalError)
            return
        }
    
        var receipients = [String]()
        var message = selectedColor.message
        
        for contact in selectedColor.contacts{
            for phone in contact.phones{
                receipients.append(phone.number)
            }
        }
        
        if receipients.count == 0{
            showError(withMessage: noContactsMessage)
            return
        }
        
        message = selectedColor.message
        
        
        
        let messageVC = MFMessageComposeViewController()
        messageVC.messageComposeDelegate = self
        messageVC.recipients = receipients
        messageVC.body = message
        if selectedColor.locationStatus{
            if let userLocation = userLocation{
                message =  message + "And my location is at : \n" + getLocationLink(forUserCoordinates: userLocation)
            }
        }
        messageVC.body = message
        
        self.present(messageVC, animated: true, completion: nil)
    }
    
    func getLocationLink(forUserCoordinates coordinates: coordinates) ->String{
        let link = "https://maps.google.com/?saddr=%\(coordinates.lattitude)f,%\(coordinates.longitude)f"
        return link
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


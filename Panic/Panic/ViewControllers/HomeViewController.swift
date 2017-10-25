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
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    
    let manageController = ManageController.sharedInstance
    let themeController = ThemeController.sharedInstance
    
    var colors: (red: Color?, yellow: Color?, green: Color?)?
    var selectedColor: Color?
    let messageServiceNotAvailable = "SMS services are not available"
    
    let noContactsMessage = "No contacts added. Please add them first"
    let generalError = "Something went wrong. Please restart the app again"
    let messageSent = "Message sent"
    
    let fatatErrorMessage = "Could not initiate app. Please re install or contact us"
    
    let locationManager = CLLocationManager()
    lazy var canSendSMS = MFMessageComposeViewController.canSendText()
    
    typealias coordinates = (lattitude: String, longitude: String)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupLocationServices()
        checkSmsService()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getColors()
        
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
        createColorsAndThemes()
    }
    
    func getColors(){
        do{
            colors = try manageController.getColorsTuple()
        }catch{
            showError(withMessage: generalError)
        }
    }
    
    func checkSmsService(){
        if !canSendSMS{
            UIAlertController.showErrorAlert(withMessage: messageServiceNotAvailable, inView: self)
        }
    }
    
    func createColorsAndThemes(){
        do{
            try manageController.createColors()
            try themeController.createTheme()
        }catch{
            showError(withMessage: fatatErrorMessage)
        }
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
        
        if !canSendSMS{
            UIAlertController.showErrorAlert(withMessage: messageServiceNotAvailable, inView: self)
            return
        }
        
        
        guard let selectedColor = selectedColor else{
            showError(withMessage: generalError)
            return
        }
        DispatchQueue.global().async {[weak self] in
            self?.prepareMessageUIfor(selectedColor, userLocation: userLocation)
        }
      
    }
    
    func prepareMessageUIfor(_ color: Color, userLocation: coordinates?){
        
        var receipients = [String]()
        var message = color.message
        
        let contacts = try! manageController.getContacts(forColor: color.name)
        
        for contact in contacts{
            for phone in contact.phones{
                receipients.append(phone.number)
            }
        }
        
        if receipients.count == 0{
            showError(withMessage: noContactsMessage)
            return
        }
        
        message = color.message
        let messageVC = MFMessageComposeViewController()
        messageVC.messageComposeDelegate = self
        messageVC.recipients = receipients
        messageVC.body = message
        if color.locationStatus{
            if let userLocation = userLocation{
                let link = getLocationLink(forUserCoordinates: userLocation)
                let locationURL = URL(string:link)
                messageVC.addAttachmentURL(locationURL!, withAlternateFilename: "link")
                message =  message + "And my location is : \n" + link
            }
        }
        messageVC.body = message
        DispatchQueue.main.async {[weak self] in
            self?.present(messageVC, animated: true, completion: nil)
        }
        
    }
    
    
    func getLocationLink(forUserCoordinates coordinates: coordinates) ->String{
       let link = "http://maps.apple.com/?ll=\(coordinates.lattitude),\(coordinates.longitude)"
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


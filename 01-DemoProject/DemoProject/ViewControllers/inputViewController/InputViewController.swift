//
//  inputViewController.swift
//  DemoProject
//
//  Created by Richa Pandey on 10/12/16.
//  Copyright © 2016 Richa Pandey. All rights reserved.
//

import UIKit
import CoreLocation

let keyBoardBuffer = 150

class InputViewController: UIViewController,UITextFieldDelegate , InputViewPickerSelectedValueDelegate ,InputViewTableSelectedValueDelegate , UIGestureRecognizerDelegate,CLLocationManagerDelegate {


    
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var roomTextField: UITextField!
    @IBOutlet weak var guestTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!    
    @IBOutlet weak var cityTableView: UITableView!

    
    var datePicker: UIDatePicker!
    var valuePicker: UIPickerView!
    var pickerDelegate : inputViewPickerDelegate!
    var listDelegate : inputViewTableViewDelegate!
    var cityArray : NSMutableArray!
    var listView  = ListViewController()
    var locationManager = CLLocationManager()

    
    
    //MARK:
    //MARK: - lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialAllocation()
        self .setInitialValue()
        self.getCurrentLocation()
        self.getAllCityNames()
        self.setupNaviagtionBarForInputViewController()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK:
    //MARK: - custom methods
    
    /*
     @brief : method to allocate all initail values for all variables
     */
    func initialAllocation() {
        if pickerDelegate == nil {
            pickerDelegate = inputViewPickerDelegate()
            pickerDelegate.delegate = self
        }
        if listDelegate == nil {
            listDelegate = inputViewTableViewDelegate()
            listDelegate.delegate = self
        }
        self.cityTableView.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(inputViewController!.dismissKeyboard))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    
    }
    
    /*
     @brief : method to set all initail values
     */
    func setInitialValue()  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        startDateTextField.text = dateFormatter.string(from: NSDate() as Date)
        endDateTextField.text = dateFormatter.string(from: NSDate() as Date)
    }
    
    
    /*
     @brief : method to get current location
     */
    func getCurrentLocation() {
        if (CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            if ((UIDevice.current.systemVersion as NSString).floatValue >= 8){
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.startUpdatingLocation()
        } else {
            UIAlertView.init(title: "Location services are not enabled", message: nil, delegate: nil, cancelButtonTitle: "Ok").show()
        }
    }
    
    
    /*
     @brief : method to setup for city table view
     */
    func getAllCityNames() {
        cityArray = NSMutableArray(array: ["Bangalore", "Chennai", "Kolkata"])
        self.cityTableView.delegate = listDelegate
        self.cityTableView.dataSource = listDelegate
        self.listDelegate.listArray = cityArray.mutableCopy() as! NSMutableArray
        self.cityTableView.reloadData()
    }
    
    
    /*
     @brief : method to setup custom navigation bar for the input view controller
     */
    func setupNaviagtionBarForInputViewController(){
        self.navigationController?.isNavigationBarHidden=false
        self.title = "Welcome to demo project"
    }
    
    /*
     @brief : methode to show city name from the coordinate
     */
    func getCityNameFromCoordinate(coordinate : CLLocationCoordinate2D)  {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                self.cityTextField.text = city as String
            }
        })
    }
    
    /*
     @brief : method to search city
     */
    func searchCityListForString(searchString : NSString) {
        if searchString.length > 0 {
            let predicate = NSPredicate(format: "SELF CONTAINS[cd] %@", searchString)
            let searchResults = cityArray.filtered(using: predicate)
            self.listDelegate.listArray = searchResults as! NSMutableArray
        } else{
            self.listDelegate.listArray = cityArray as NSMutableArray
        }
        self.cityTableView.reloadData()
    }
    
    /*
     @brief : methode to push the view up while keyboard appering
     */
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
   
    //MARK
    //MARK: - actions
    
    /*
     @brief : date picker action methods
     */
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        if sender.tag == 1 {
            startDateTextField.text = dateFormatter.string(from: sender.date)
        } else if sender.tag == 2 {
            endDateTextField.text = dateFormatter.string(from: sender.date)
        }
    }
    
    
    /*
     @brief : get current location button action methods
     */
    @IBAction func currentLocationButtonAction(_ sender: AnyObject) {
        self.getCurrentLocation()
    }
    
    /*
     @brief : submit button action methods
     */
    @IBAction func submitButtonAction(_ sender: AnyObject) {
        if (self.startDateTextField.text?.lengthOfBytes(using: .utf8))! <= 0 {
            UIAlertView.init(title: "Start date cannot be blank", message: "", delegate: nil, cancelButtonTitle: "Ok").show()
            return
        }
        
        if (self.endDateTextField.text?.lengthOfBytes(using: .utf8))! <= 0 {
            UIAlertView.init(title: "End date cannot be blank", message: "", delegate: nil, cancelButtonTitle: "Ok").show()
            return
        }
        
        if (self.guestTextField.text?.lengthOfBytes(using: .utf8))! <= 0 {
            UIAlertView.init(title: "No of guest cannot be blank", message: "", delegate: nil, cancelButtonTitle: "Ok").show()
            return
        }
        
        if (self.roomTextField.text?.lengthOfBytes(using: .utf8))! <= 0 {
            UIAlertView.init(title: "No of room cannot be blank", message: "", delegate: nil, cancelButtonTitle: "Ok").show()
            return
        }
        
        if (self.cityTextField.text?.lengthOfBytes(using: .utf8))! <= 0 {
            UIAlertView.init(title: "City cannot be blank", message: "", delegate: nil, cancelButtonTitle: "Ok").show()
            return
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        listView = (storyBoard.instantiateViewController(withIdentifier: "listViewControllerIdentifier") as? ListViewController)!

        listView.startDate = self.startDateTextField.text as NSString!
        listView.endDate  = self.endDateTextField.text as NSString!
        listView.guestNo  = self.guestTextField.text as NSString!
        listView.roomNo = self.roomTextField.text as NSString!
        listView.locationName = self.cityTextField.text as NSString!
        self.navigationController?.pushViewController(listView, animated: true)


    }
    
    
    /*
     @brief : Calls this function when the tap is recognized for dismissing keyboard.
     */
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK
    //MARK: - uitext field delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        if (textField.tag == 1 || textField.tag == 2 ){
            if datePicker == nil{
                datePicker = UIDatePicker()
            }
            datePicker.datePickerMode = UIDatePickerMode.date
            textField.inputView = datePicker
            datePicker.tag = textField.tag
            datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
        
        if (textField.tag == 3 || textField.tag == 4 ){
            if valuePicker == nil{
                valuePicker = UIPickerView()
            }
            valuePicker.delegate = pickerDelegate
            textField.inputView = valuePicker
            valuePicker.tag = textField.tag
        }
        
        if textField.tag == 5 {
            self.animateViewMoving(up: true, moveValue: CGFloat(keyBoardBuffer))
            self.cityTableView.isHidden = false
            return true
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 5 {
            self.cityTableView.isHidden = true
            self.animateViewMoving(up: false, moveValue: CGFloat(keyBoardBuffer))
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 5 {
            let updatedString : NSString = ((textField.text as NSString?)!.replacingCharacters(in: range, with: string) as NSString)
            self.searchCityListForString(searchString: updatedString as NSString)
        }
        return true
    }
    
    
    //MARK
    //MARK: - gesture delegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.cityTableView))!{
            return false
        }
        return true
    }
    
    
    //MARK
    //MARK: - locationManager Delegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        UIAlertView.init(title: error.localizedDescription, message: "", delegate: nil, cancelButtonTitle: "OK").show()

    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        
        self.getCityNameFromCoordinate(coordinate: coord)
        
        print(coord.latitude)
        print(coord.longitude)

    }
    
    //MARK
    //MARK: - inputViewPickerSelectedValueDelegate
    func pickerValueSelected(tag: NSInteger, value: NSInteger) {
        if tag == 3 {
            roomTextField.text = NSString.init(format: "%d", value) as String
        } else if tag == 4 {
            guestTextField.text = NSString.init(format: "%d", value) as String
        }
    }
    
    
    //MARK
    //MARK: -     inputViewTableSelectedValueDelegate
    func tableValueSelected(index: NSInteger, value: NSString) {
      cityTextField.text = value as String
        self.cityTableView.isHidden = true
        self.cityTextField.resignFirstResponder()
    }
    

}

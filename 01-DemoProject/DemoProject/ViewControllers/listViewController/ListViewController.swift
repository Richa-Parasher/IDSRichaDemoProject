//
//  listViewController.swift
//  DemoProject
//
//  Created by Richa Pandey on 10/12/16.
//  Copyright © 2016 Richa Pandey. All rights reserved.
//

import UIKit

class ListViewController: UIViewController , InputViewTableSelectedValueDelegate ,UIGestureRecognizerDelegate {

    @IBOutlet weak var startDateLable: UILabel!
    @IBOutlet weak var endDateLable: UILabel!
    @IBOutlet weak var guestNoLable: UILabel!
    @IBOutlet weak var roomNoLable: UILabel!
    @IBOutlet weak var sortLable: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var dropDownTableView: UITableView!
    @IBOutlet weak var sortButton: UIButton!

    var locationName : NSString!
    var startDate : NSString!
    var endDate : NSString!
    var guestNo : NSString!
    var roomNo : NSString!
    var itemArray : NSMutableArray!
    var listDelegate : ListVIewTableViewDelegate!
    var dropDownDelegate : inputViewTableViewDelegate!

    
    //MARK:
    //MARK: - lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if listDelegate == nil {
            listDelegate = ListVIewTableViewDelegate()
        }
        
        if dropDownDelegate == nil {
            dropDownDelegate = inputViewTableViewDelegate()
            dropDownDelegate.delegate = self
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissDropDown))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        self.setupSortDropDown()
        self.getAllItemsList()
        self.showAllValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK:
    //MARK: - custom methods
    
    /*
     @brief : method to setup setup sort drop down
     */
    func setupSortDropDown(){
        let dropDownArray : NSMutableArray = NSMutableArray(array: ["High > Low", "Low > High", "By Rating"])
        self.dropDownTableView.delegate = dropDownDelegate
        self.dropDownTableView.dataSource = dropDownDelegate
        self.dropDownDelegate.listArray = dropDownArray.mutableCopy() as! NSMutableArray
        self.dropDownTableView.reloadData()
        self.dropDownTableView.isHidden = true
    }
    
    /*
     @brief : method to setup custom navigation bar for the input view controller
     */
    func showAllValues(){
        self.navigationController?.isNavigationBarHidden=false
        self.title = self.locationName as String!
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.startDateLable.text = self.startDate as String?
        self.endDateLable.text = self.endDate as String?
        self.guestNoLable.text = self.guestNo as String?
        self.roomNoLable.text = self.roomNo as String?
    }

    /*
     @brief : method to setup for city table view
     */
    func getAllItemsList() {
        itemArray = DataModel.getHotelListArray()
        self.listTableView.delegate = listDelegate
        self.listTableView.dataSource = listDelegate
        self.listDelegate.listArray = itemArray.mutableCopy() as! NSMutableArray
        self.listTableView.reloadData()
    }
    
    
    //MARK:
    //MARK: - action methods
    
    /*
     @brief : method for sort button action
     */
    @IBAction func sortButtonAction(_ sender: AnyObject) {
        self.dropDownTableView.isHidden = false
    }
    
    /*
     @brief : Calls this function when the tap is recognized for dismissing keyboard.
     */
    func dismissDropDown() {
        self.dropDownTableView.isHidden = true
    }
    
    
    //MARK
    //MARK: -     inputViewTableSelectedValueDelegate
    func tableValueSelected(index: NSInteger, value: NSString) {
        switch index {
        case 0:
            let descriptor: NSSortDescriptor =  NSSortDescriptor(key: "discountAmount", ascending: false, selector: #selector(NSString.caseInsensitiveCompare(_:)))
            let sortedResults: NSArray = itemArray.sortedArray(using: [descriptor]) as NSArray
            self.listDelegate.listArray = sortedResults.mutableCopy() as! NSMutableArray
            self.listTableView.reloadData()
            sortButton.tag = NSInteger(2)
            sortLable.text = "H > L"
            break
        case 1:
            let descriptor: NSSortDescriptor =  NSSortDescriptor(key: "discountAmount", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
            let sortedResults: NSArray = itemArray.sortedArray(using: [descriptor]) as NSArray
            self.listDelegate.listArray = sortedResults.mutableCopy() as! NSMutableArray
            self.listTableView.reloadData()
            sortButton.tag = NSInteger(3)
            sortLable.text = "L > H"
            break
        case 2:
            let descriptor: NSSortDescriptor =  NSSortDescriptor(key: "ratting", ascending: false, selector: #selector(NSString.caseInsensitiveCompare(_:)))
            let sortedResults: NSArray = itemArray.sortedArray(using: [descriptor]) as NSArray
            self.listDelegate.listArray = sortedResults.mutableCopy() as! NSMutableArray
            self.listTableView.reloadData()
            sortButton.tag = NSInteger(1)
            sortLable.text = "Rating"
            break
        default:
            break
        }
        self.dropDownTableView.isHidden = true
    }

    //MARK
    //MARK: - gesture delegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.dropDownTableView))!{
            return false
        }
        return true
    }

}

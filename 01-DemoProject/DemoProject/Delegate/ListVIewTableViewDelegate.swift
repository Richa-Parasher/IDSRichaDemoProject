//
//  listVIewTableViewDelegate.swift
//  DemoProject
//
//  Created by Richa Pandey on 10/13/16.
//  Copyright © 2016 Richa Pandey. All rights reserved.
//

import UIKit

class ListVIewTableViewDelegate: NSObject , UITableViewDelegate , UITableViewDataSource {

    var listArray : NSMutableArray!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "listCellIdentifier") as! ListTableViewCell!
        let cellDictionary : NSMutableDictionary = listArray.object(at: indexPath.row) as! NSMutableDictionary
        
        cell.titleLable.text = cellDictionary.object(forKey: "name") as? String
        cell.discountAmountLable.text = cellDictionary.object(forKey: "discountAmount") as? String
        
        
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: (cellDictionary.object(forKey: "amount") as? String)!)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        
        cell.exactAmountLable.attributedText = attributeString
        
        
        
        
        let rattingString : String = (cellDictionary.object(forKey: "ratting") as? String)!
        
        
        let ratting : NSInteger = Int(rattingString)!
        
        cell.star1.image =  UIImage.init(named: "UnSelectedStar")
        cell.star2.image =  UIImage.init(named: "UnSelectedStar")
        cell.star3.image =  UIImage.init(named: "UnSelectedStar")
        cell.star4.image =  UIImage.init(named: "UnSelectedStar")
        cell.star5.image =  UIImage.init(named: "UnSelectedStar")

        
        switch ratting {
        case 1  :
            cell.star1.image =  UIImage.init(named: "SelectedStar")
            break
        case 2  :
            cell.star1.image =  UIImage.init(named: "SelectedStar")
            cell.star2.image =  UIImage.init(named: "SelectedStar")
            break
        case 3  :
            cell.star1.image =  UIImage.init(named: "SelectedStar")
            cell.star2.image =  UIImage.init(named: "SelectedStar")
            cell.star3.image =  UIImage.init(named: "SelectedStar")
            break
            
        case 4 :
            cell.star1.image =  UIImage.init(named: "SelectedStar")
            cell.star2.image =  UIImage.init(named: "SelectedStar")
            cell.star3.image =  UIImage.init(named: "SelectedStar")
            cell.star4.image =  UIImage.init(named: "SelectedStar")

            break
            
        case 5  :
            cell.star1.image =  UIImage.init(named: "SelectedStar")
            cell.star2.image =  UIImage.init(named: "SelectedStar")
            cell.star3.image =  UIImage.init(named: "SelectedStar")
            cell.star4.image =  UIImage.init(named: "SelectedStar")
            cell.star5.image =  UIImage.init(named: "SelectedStar")

            break
            
        default : break
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    
}

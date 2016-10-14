//
//  inputViewTableViewDelegate.swift
//  DemoProject
//
//  Created by Richa Pandey on 10/12/16.
//  Copyright © 2016 Richa Pandey. All rights reserved.
//

import UIKit

protocol InputViewTableSelectedValueDelegate:class {
    func tableValueSelected(index:NSInteger , value:NSString)
}

class inputViewTableViewDelegate: NSObject, UITableViewDelegate , UITableViewDataSource {
    
    weak var delegate:InputViewTableSelectedValueDelegate?

    
    var listArray : NSMutableArray!

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellIdentifier")!
        let cellText : NSString = listArray.object(at: indexPath.row) as! NSString
        cell.textLabel?.text = cellText as String;
        cell.textLabel?.font = UIFont.init(name: "Gill Sans", size: 13.0)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellText : NSString = listArray.object(at: indexPath.row) as! NSString
        delegate?.tableValueSelected(index: indexPath.row, value: cellText)
    }
    
}

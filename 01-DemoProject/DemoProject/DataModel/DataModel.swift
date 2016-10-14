//
//  dataModel.swift
//  DemoProject
//
//  Created by Richa Pandey on 10/13/16.
//  Copyright © 2016 Richa Pandey. All rights reserved.
//

import UIKit

class DataModel: NSObject {

    
    class func getHotelListArray() -> NSMutableArray{
        let returnArray : NSMutableArray  = NSMutableArray.init()
        
        let valueDictionary1 : NSMutableDictionary  = NSMutableDictionary.init()
        valueDictionary1.setValue("Hotel Nandini", forKey: "name")
        valueDictionary1.setValue("3000", forKey: "amount")
        valueDictionary1.setValue("2000", forKey: "discountAmount")
        valueDictionary1.setValue("3", forKey: "ratting")

        let valueDictionary2 : NSMutableDictionary  = NSMutableDictionary.init()
        valueDictionary2.setValue("Taj Hotel", forKey: "name")
        valueDictionary2.setValue("10000", forKey: "amount")
        valueDictionary2.setValue("8000", forKey: "discountAmount")
        valueDictionary2.setValue("5", forKey: "ratting")
        
        let valueDictionary3 : NSMutableDictionary  = NSMutableDictionary.init()
        valueDictionary3.setValue("The Lalith", forKey: "name")
        valueDictionary3.setValue("10000", forKey: "amount")
        valueDictionary3.setValue("7000", forKey: "discountAmount")
        valueDictionary3.setValue("4", forKey: "ratting")
        
        returnArray.add(valueDictionary1)
        returnArray.add(valueDictionary2)
        returnArray.add(valueDictionary3)

        return returnArray
        
    }
    
    
    
}

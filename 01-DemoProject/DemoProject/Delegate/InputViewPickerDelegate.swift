//
//  inputViewPickerDelegate.swift
//  DemoProject
//
//  Created by Richa Pandey on 10/12/16.
//  Copyright © 2016 Richa Pandey. All rights reserved.
//

import UIKit

protocol InputViewPickerSelectedValueDelegate:class {
    func pickerValueSelected(tag:NSInteger , value:NSInteger)
}

class inputViewPickerDelegate: NSObject , UIPickerViewDelegate , UIPickerViewDataSource {
   
    weak var delegate:InputViewPickerSelectedValueDelegate?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return NSString.init(format: "%d", row+1) as String
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerValueSelected(tag: pickerView.tag, value: row+1)
    }

    

}

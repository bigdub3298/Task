//
//  DateHelper.swift
//  Task
//
//  Created by Wesley Austin on 9/2/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

extension NSDate {

    func stringValue() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        return dateFormatter.stringFromDate(self) 
    }
}

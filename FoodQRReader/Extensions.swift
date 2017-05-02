//
//  Extensions.swift
//  FoodQRReader
//
//  Created by leo mac on 5/2/17.
//  Copyright © 2017 LionLife. All rights reserved.
//

import UIKit

extension UIView {
    
    func dropShadow() {
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 10, height: 6)
        self.layer.shadowRadius = 10
        
    }
}

extension Date {
    
    func getString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        //formatter.timeZone = TimeZone(abbreviation: "PDT")
        //formatter.timeZone = TimeZone(abbreviation: "BST")
        formatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "")
        return formatter.string(from: self)
        
    }
    
    
}

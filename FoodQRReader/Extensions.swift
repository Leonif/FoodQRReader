//
//  Extensions.swift
//  FoodQRReader
//

import UIKit

extension UIView {
    
    func dropShadow() {
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 10, height: 6)
        self.layer.shadowRadius = 10
        
    }
}

extension String {
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
}

extension Date {
    
    func getString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "")
        return formatter.string(from: self)
        
    }
    
    
}

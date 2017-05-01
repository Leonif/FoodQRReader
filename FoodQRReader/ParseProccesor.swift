//
//  ParseProccesor.swift
//  FoodQRReader
//
//  Created by leo mac on 5/1/17.
//  Copyright © 2017 LionLife. All rights reserved.
//

import AVFoundation



enum BillDataType {
    case json
    case url
    case xml
    case uknown
}






class ParseProccesor {
    
    
    static var sharedInstance = ParseProccesor()
    
    func loadParsedBill(data: String) -> [BillRow]? {
        
        
        switch dataType(data: data) {
        case .json:
            return parseJSONBill(json: data)
            
        default:
            return nil
        }
        
        
        
    }
    
    func dataType(data: String) -> BillDataType {
        
        if data.contains("{") {
            return .json
        }
        if data.contains("https://") {
            return .url
        }
        if data.contains("<") {
            return .xml
        }
        
        return .uknown
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    
    
    func parseJSONBill(json: String)->[BillRow]? {
        
        var billRows = [BillRow]()
        
        
        
        //1. try to parse
        if let dict = convertToDictionary(text: json) {
            
            for r in dict {
                
                let billrow = BillRow(billRow: r.value as! [String: Any])
                billRows.append(billrow)
            }
            return billRows
            
        }
        return nil
        
        
    }
    
    
    
    
    
}

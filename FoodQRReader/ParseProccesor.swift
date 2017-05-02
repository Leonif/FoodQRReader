//
//  ParseProccesor.swift
//  FoodQRReader
//

import AVFoundation
import Foundation



enum BillDataType {
    case json
    case url
    case xml
    case uknown
}

class ParseProccesor {
    static var sharedInstance = ParseProccesor()
    var currentElement = ""
    var foundCharacters = ""
    var xmlParser: XMLParser?
    
    func loadParsedBill(data: String) -> [BillRow]? {
        switch dataType(data: data) {
        case .json:
            return parseJSONBill(json: data)
        case .url:
            return parseURL(url:data)
        case .xml:
            return parseXML(xml: data)
        default:
            return nil
        }
        
        
        
    }
    //define what kind of type QR
    func dataType(data: String) -> BillDataType {
        
        if data.contains("{") {
            return .json
        }
        if data.contains("https://") {
            return .url
        }
        if data.contains("xml") {
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

    
    
    
    func parseXML(xml: String)->[BillRow]? {
        let rows = xml.components(separatedBy: "_id")
        print(rows.count-1)
        
        var bill = [BillRow]()
        
        
        for r in rows {
            if let name = r.slice(from: "<name>", to: "</name>") {
                if let price = Double(r.slice(from: "<price>", to: "</price>")!) {
                    if let quantity = Double(r.slice(from: "<quantity>", to: "</quantity>")!) {
                        let billrow = BillRow(name: name, price: price, quantity: quantity)
                        bill.append(billrow)
                    }
                
                }
            }
        
        }
        
        if bill.isEmpty != true {
        
            return bill
        }
        
        return nil
    }
    
    
    func parseURL(url: String)->[BillRow]? {
        
        guard let url = URL(string: url),
            let myData = NSData(contentsOf: url) as Data?, let json = String(data: myData, encoding: String.Encoding.utf8)
            else {
                return nil
        }
        
        return parseJSONBill(json: json)
    }
    
    
    func parseJSONBill(json: String)->[BillRow]? {
        
        var billRows = [BillRow]()
        if let dict = convertToDictionary(text: json) {
            
            for r in dict {
                if let billRow = r.value as? [String: Any] {
                    billRows.append(BillRow(billRow: billRow))
                }
            }
            if billRows.isEmpty != true {
                return billRows
            }
            
        }
        return nil
        
        
    }
}



















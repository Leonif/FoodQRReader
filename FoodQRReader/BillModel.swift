//
//  BillModel.swift
//  FoodQRReader
//
//  Created by leo mac on 5/1/17.
//  Copyright © 2017 LionLife. All rights reserved.
//

import AVFoundation
import QRCodeReader

class BillRow {
    
    var name = ""
    var price = 0.00
    var quantity = 0
    
    init(billRow: [String:Any]) {
        self.name = billRow["name"] as! String
        self.price = billRow["price"] as! Double
        self.quantity = billRow["quantity"] as! Int
    }
}

class BillModel{
    
    var billrows = [BillRow]()
    
    func loadParsedBill(result:QRCodeReaderResult) {
        
        billrows.removeAll()
        //1. try to parse
        if let dict = convertToDictionary(text: result.value) {
            for r in dict {
                let billrow = BillRow(billRow: r.value as! [String: Any])
                billrows.append(billrow)
            }
        }
    }
    
    //"{\"cake_id\":{\"name\":\"cake\",\"price\":1.99,\"quantity\":2},
    //\"coffee_id\":{\"name\":\"coffee\",\"price\":1.39,\"quantity\":1},\
    //"juice_id\":{\"name\":\"juice\",\"price\":1.45,\"quantity\":1},\
    //"scrumble_id\":{\"name\":\"scrumble\",\"price\":2.99,\"quantity\":2}}"
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

    func parseJSONBill() {
        //TODO: read into billRows
    }
}

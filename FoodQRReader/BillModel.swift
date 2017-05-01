//
//  BillModel.swift
//  FoodQRReader
//
//  Created by leo mac on 5/1/17.
//  Copyright © 2017 LionLife. All rights reserved.
//


import QRCodeReader




class BillRow {
    
    var name = ""
    var price = 0.00
    var quantity = 0.00
    
    init(billRow: [String:Any]) {
        self.name = billRow["name"] as! String
        self.price = billRow["price"] as! Double
        self.quantity = billRow["quantity"] as! Double
   
    }
    init(name: String, price: Double, quantity: Double) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}


class BillHistory {
    
    var history = [BillModel]()
    
    
    func add(bill: BillModel) {
        
        history.append(bill)
        
        
    }
    
}


class BillModel {
    
    var billrows = [BillRow]()
    var scanDate: Date?
    
    
    func loadParsedBill(result: QRCodeReaderResult) -> Bool {
        
        if let b = ParseProccesor.sharedInstance.loadParsedBill(data: result.value) {
            scanDate = Date()
            billrows = b
            return true
        }
        return false
    }
    
    var count: Int {
        
        return billrows.count
    }
    
    func name(index: IndexPath) -> String {
        return billrows[index.row].name
    }
    func price(index: IndexPath) -> Double {
        return billrows[index.row].price
    }
    func quantity(index: IndexPath) -> Double {
        return billrows[index.row].quantity
    }
    func sum(index: IndexPath) -> Double {
        return billrows[index.row].quantity * billrows[index.row].price
    }
        
    
}


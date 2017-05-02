//
//  BillModel.swift
//  FoodQRReader
//


import QRCodeReader


class BillRow {
    
    var name = ""
    var price = 0.00
    var quantity = 0.00
    
    init(billRow: [String:Any]) {
        if let name = billRow["name"] as? String  {
            self.name = name
            if let price = billRow["price"] as? Double  {
                self.price = price
                if let quantity = billRow["quantity"] as? Double {
                    self.quantity = quantity
                }
            }
        }
        
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
    
    var count: Int  {
        return history.count
    }
    
    func scanDate(indexPath: IndexPath) -> String {
        return history[indexPath.row].scanDate!.getString(format: "dd.MM.yyyy hh:mm:ss")
    }
    func billTotal(indexPath: IndexPath) -> Double {
        return history[indexPath.row].billTotal
    }
    
    func bill(indexPath: IndexPath)->BillModel  {
        
        return history[indexPath.row]
    }
    
}


class BillModel {
    
    var billrows = [BillRow]()
    var scanDate: Date?
    
    func loadParsedBill(result: QRCodeReaderResult) -> BillModel? {
        if let b = ParseProccesor.sharedInstance.loadParsedBill(data: result.value) {
            scanDate = Date()
            billrows = b
            return self
        }
        return nil
    }
    
    
    
    
    var count: Int {
        return billrows.count
    }
    
    func name(index: IndexPath) -> String {
        return billrows[index.row].name.capitalized
    }
    func price(index: IndexPath) -> Double {
        return billrows[index.row].price
    }
    func quantity(index: IndexPath) -> Double {
        return billrows[index.row].quantity
    }
    func sumRow(index: IndexPath) -> Double {
        return billrows[index.row].quantity * billrows[index.row].price
    }
    var billTotal: Double {
        var sum = 0.0
        for r in billrows {
            sum += r.quantity * r.price
        }
        return sum
    }
        
    
}





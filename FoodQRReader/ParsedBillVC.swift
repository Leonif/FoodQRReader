//
//  ParsedBillVC.swift
//  FoodQRReader
//
//

import UIKit

class ParsedBillVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var billTableView: UITableView!
    
    @IBOutlet weak var billTotalLabel: UILabel!
    var parsedBill: BillModel!
    var idBillRowCell = "billRowCell"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        billTableView.delegate = self
        billTableView.dataSource = self
        billTotalLabel.text = "Total: \(parsedBill.billTotal)"
        

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return parsedBill?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = billTableView.dequeueReusableCell(withIdentifier: idBillRowCell, for: indexPath) as? billRowCellTableViewCell {
        
            let bill = parsedBill
            
            cell.name.text = bill?.name(index: indexPath)
            cell.price.text = "price: \(bill?.price(index: indexPath) ?? 0)"
            cell.quantity.text = "quantity: \(bill?.quantity(index: indexPath) ?? 0)"
            cell.sum.text = "sum: \(bill?.sumRow(index: indexPath) ?? 0)"
            
            
            return cell
        }
        return UITableViewCell()
    }
    
}

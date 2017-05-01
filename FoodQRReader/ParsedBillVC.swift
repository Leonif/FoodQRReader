//
//  ParsedBillVC.swift
//  FoodQRReader
//
//

import UIKit

class ParsedBillVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var billTableView: UITableView!
    
    var parsedBill: BillModel!
    var idBillRowCell = "billRowCell"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        billTableView.delegate = self
        billTableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return parsedBill?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = billTableView.dequeueReusableCell(withIdentifier: idBillRowCell, for: indexPath)
        
        cell.textLabel?.text = parsedBill?.name(index: indexPath)
        
        return cell
    }
    
}

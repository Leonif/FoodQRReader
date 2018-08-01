//
//  ParsedBillVC.swift
//  FoodQRReader
//
//

import UIKit

class ParsedBillVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var billTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        billTableView.delegate = self
        billTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

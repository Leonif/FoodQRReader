//
//  MainVC.swift
//  FoodQRReader
//

import UIKit
import AVFoundation
import QRCodeReader

class MainVC: UIViewController, QRCodeReaderViewControllerDelegate, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var billHistoryTableView: UITableView!
    var billModel = BillModel()
    var history = BillHistory()
    var cellId = "historyCell"
    
    var showParsedBill = "showParsedBill"
    var showBill = "showBill"
    
    override func viewWillAppear(_ animated: Bool) {
        billHistoryTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billHistoryTableView.delegate = self
        billHistoryTableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = billHistoryTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? HistoryCell {
            
            cell.dateLabel.text = "Scanned: \(history.scanDate(indexPath: indexPath))"
            cell.sumLabel.text = "Total: \(history.billTotal(indexPath: indexPath))"
            
            
            return cell
        }
        return UITableViewCell()
    }

    //get bill and pass it to bill controller
    @IBAction func scanBill(_ sender: Any) {
        
        readerVC.delegate = self
        
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            
            if let billResult = result {
                if self.billModel.loadParsedBill(result: billResult) {
                    
                    self.history.add(bill: self.billModel)
                    self.performSegue(withIdentifier: self.showParsedBill, sender: nil)
                }
            }
        }
        
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showParsedBill {
            if let vc = segue.destination as? ParsedBillVC {
                vc.parsedBill = billModel
            }
        }
        if segue.identifier == showBill {
            if let vc = segue.destination as? ParsedBillVC {
                if let indexPath = sender as? IndexPath  {
                    vc.parsedBill = history.bill(indexPath: indexPath)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showBill, sender: indexPath)
    }
    
    // Good practice: create the reader lazily to avoid cpu overload during the
    // initialization and each time we need to scan a QRCode
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    // MARK: - QRCodeReaderViewController Delegate Methods
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
    
    //This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    //By pressing on the switch camera button
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            print("Switching capturing to: \(cameraName)")
        }
    }
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }

    
    
    
    
    
    
    

}


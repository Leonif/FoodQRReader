//
//  HistoryCell.swift
//  FoodQRReader
//
import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var sumLabel: UILabel!
    @IBOutlet var cellView: UIView!
    
    
    override func awakeFromNib() {
        cellView.dropShadow()
    }

}

//
//  HistoryCell.swift
//  FoodQRReader
//
//  Created by leo mac on 5/1/17.
//  Copyright © 2017 LionLife. All rights reserved.
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

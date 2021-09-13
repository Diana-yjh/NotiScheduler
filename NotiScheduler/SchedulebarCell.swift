//
//  SchedulebarCell.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/10.
//

import Foundation
import UIKit

class SchedulebarCell: UITableViewCell {
    
    @IBOutlet weak var addButton: UIButton!
    
    override func layoutSubviews(){
        super.layoutSubviews()
        addButton.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}

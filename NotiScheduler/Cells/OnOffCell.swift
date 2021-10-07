//
//  TableViewCell.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/10.
//

import Foundation
import UIKit

class SchedulebarCell: UITableViewCell {
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
}

class ScheduleCell: UITableViewCell {
    
    @IBOutlet weak var scheduleName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var scheduleIcon: UIButton!
    
    var onOffStatus: Bool  = true
    
    override func layoutSubviews(){
        super.layoutSubviews()
        self.day.numberOfLines = 0
    }
}

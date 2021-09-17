//
//  TableViewCell.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/10.
//

import Foundation
import UIKit

class OnOffCell: UITableViewCell {
    @IBOutlet weak var onOffButton: UISwitch!
    
    public var status: Bool = true
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func onOffButton(_ sender: Any) {
        if status == true {
            status = false
        } else {
            status = true
        }
    }
}

class SchedulebarCell: UITableViewCell {
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
}

class ScheduleCell: UITableViewCell {
    
    @IBOutlet weak var scheduleNumber: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    @IBOutlet weak var scheduleIcon: UIButton!
    
    var onOffStatus: Bool  = true
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
//    func onOffButtonStatus() {
//        if onOffStatus == true {
//            let offImage = UIImage(systemName: "calendar")?.withTintColor(.gray)
//            scheduleIcon.setImage(offImage, for: .normal)
//        } else {
//            let onImage = UIImage(systemName: "calendar")?.withTintColor(UIColor(red: 147, green: 183, blue: 81, alpha: 1))
//            scheduleIcon.setImage(onImage, for: .normal)
//        }
//    }
}

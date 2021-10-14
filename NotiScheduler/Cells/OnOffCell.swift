//
//  TableViewCell.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/10.
//

import Foundation
import UIKit

protocol SchedulebCellDelegate {
    func onOffControllInMain(onOffStatus: Bool, index: IndexPath)
}

class SchedulebarCell: UITableViewCell {
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
}

class ScheduleCell: UITableViewCell {
    
    @IBOutlet weak var scheduleName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var scheduleOnOffIcon: UIButton!
    @IBOutlet weak var scheduleOnOffLabel: UILabel!
    
    var onOffStatus: Bool  = true
    var index: IndexPath = IndexPath()
    
    var scheduleCellDelegate: SchedulebCellDelegate?
    
    func onOffScheduleInMain(_ onOffStatus: Bool){
        if onOffStatus == true {
            scheduleOn(scheduleOnOffIcon, scheduleOnOffLabel)
        } else {
            scheduleOff(scheduleOnOffIcon, scheduleOnOffLabel)
        }
    }
    
    @IBAction func onOffScheduleInMain(_ sender: Any) {
        if onOffStatus == false {
            scheduleOn(scheduleOnOffIcon, scheduleOnOffLabel)
            onOffStatus = true
            self.scheduleCellDelegate?.onOffControllInMain(onOffStatus: onOffStatus, index: index)
        } else {
            scheduleOff(scheduleOnOffIcon, scheduleOnOffLabel)
            onOffStatus = false
            self.scheduleCellDelegate?.onOffControllInMain(onOffStatus: onOffStatus, index: index)
        }
    }
    
    func scheduleOn(_ icon: UIButton, _ label: UILabel){
        icon.setImage(UIImage(named:"circlebadge.fill.green.png"), for: .normal)
        
        label.text = NSLocalizedString("on", comment: "")
        label.textColor = UIColor(red: 141/225.0, green: 183/225.0, blue: 74/225.0, alpha: 1.0)
    }
    
    func scheduleOff(_ icon: UIButton, _ label: UILabel){
        icon.setImage(UIImage(named:"circlebadge.fill.gray.png"), for: .normal)
        label.text = NSLocalizedString("off", comment: "")
        label.textColor = UIColor(red: 137/225.0, green: 137/225.0, blue: 137/225.0, alpha: 1.0)
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        self.day.numberOfLines = 0
    }
}

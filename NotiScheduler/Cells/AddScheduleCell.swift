//
//  ManagerCell.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/15.
//

import Foundation
import UIKit

protocol OnOffCell2Delegate {
    func showAlert()
}

protocol ScheduleOnOffDelegate {
    func disableCell(status: Bool)
}

class OnOffCell2: UITableViewCell {
    
    @IBOutlet weak var scheduleName: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var scheduleOnOff: UISwitch!
    
    var onOffCell2Delegate: OnOffCell2Delegate?
    var scheduleOnOffDelegate: ScheduleOnOffDelegate?
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func editScheduleNameButton(_ sender: Any) {
        self.onOffCell2Delegate?.showAlert()
    }
    
    @IBAction func scheduleOnOffButton(_ sender: Any) {
        self.scheduleOnOffDelegate?.disableCell(status: scheduleOnOff.isOn)
    }
}

class DayOnOffCell: UITableViewCell {
    
    @IBOutlet weak var sun: UIButton!
    @IBOutlet weak var mon: UIButton!
    @IBOutlet weak var tue: UIButton!
    @IBOutlet weak var wed: UIButton!
    @IBOutlet weak var thur: UIButton!
    @IBOutlet weak var fri: UIButton!
    @IBOutlet weak var sat: UIButton!
    
    var sunOnOff: Bool = false
    var monOnOff: Bool = false
    var tueOnOff: Bool = false
    var wedOnOff: Bool = false
    var thurOnOff: Bool = false
    var friOnOff: Bool = false
    var satOnOff: Bool = false
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func dayOnOff(_ sender: UIButton) {
        print("sender.tag = \(sender.tag)")
        var dayState: Bool = false
        var day: UIButton = UIButton()
        var text: String = ""
        
        switch sender.tag {
        case 0:
            dayState = sunOnOff
            day = sun
            text = "s"
            sunOnOff = buttonOnOff(dayState, day, text)
        case 1:
            dayState = monOnOff
            day = mon
            text = "m"
            monOnOff = buttonOnOff(dayState, day, text)
        case 2:
            dayState = tueOnOff
            day = tue
            text = "t"
            tueOnOff = buttonOnOff(dayState, day, text)
        case 3:
            dayState = wedOnOff
            day = wed
            text = "w"
            wedOnOff = buttonOnOff(dayState, day, text)
        case 4:
            dayState = thurOnOff
            day = thur
            text = "t"
            thurOnOff = buttonOnOff(dayState, day, text)
        case 5:
            dayState = friOnOff
            day = fri
            text = "f"
            friOnOff = buttonOnOff(dayState, day, text)
        case 6:
            dayState = satOnOff
            day = sat
            text = "s"
            satOnOff = buttonOnOff(dayState, day, text)
        default:
            return
        }
    }
    
    func buttonOnOff(_ dayState: Bool, _ day: UIButton, _ text: String) -> Bool {
        if dayState == false {
            day.setImage(UIImage(systemName: "\(text).circle.fill")?.withTintColor(UIColor(red: 138/225.0, green: 186/225.0, blue: 81/225.0, alpha: 1.0), renderingMode: .alwaysOriginal), for: .normal)
            return true
        } else {
            day.setImage(UIImage(systemName: "\(text).circle.fill")?.withTintColor(UIColor(red: 137/225.0, green: 137/225.0, blue: 137/225.0, alpha: 1.0), renderingMode: .alwaysOriginal), for: .normal)
            return false
        }
    }
}

class TimeCell: UITableViewCell {
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func startTime(_ sender: UIButton) {
        let picker = startTimePicker!
        let date = picker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour!
        let minute = components.minute!
        print("startHour = \(hour), startMinutes = \(minute)")
    }
    
    @IBAction func endTime(_ sender: UIButton) {
        let picker = endTimePicker!
        let date = picker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour!
        let minute = components.minute!
        print("endHour = \(hour), endMinutes = \(minute)")
    }
}

class CancelCell: UITableViewCell {
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
}

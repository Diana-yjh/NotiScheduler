//
//  ManagerCell.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/15.
//

import Foundation
import UIKit

//MARK: - Delegates
protocol OnOffCell2Delegate {
    func editNameAlert()
    func disableCell(status: Bool)
}

protocol DayOnOffCellDelegate {
    func selectedDay(dayArray: [String])
}

protocol TimeCellDelegate {
    func startTime(time: String)
    func endTime(time: String)
}
protocol CancelCellDelegate {
    func dismissController()
}

protocol DeleteCellDelegate {
    func deleteCell()
}

//MARK: - OnOffCell2
class OnOffCell2: UITableViewCell {
    
    @IBOutlet weak var scheduleName: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var scheduleOnOff: UIButton!
    
    var onOffCell2Delegate: OnOffCell2Delegate?
    var scheduleOnOffStatus: Bool = true
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func editScheduleNameButton(_ sender: Any) {
        self.onOffCell2Delegate?.editNameAlert()
    }
    
    @IBAction func scheduleOnOffButton(_ sender: Any) {
        if scheduleOnOffStatus == true {
            scheduleOnOffStatus = false
            self.onOffCell2Delegate?.disableCell(status: scheduleOnOffStatus)
        } else {
            scheduleOnOffStatus = true
            self.onOffCell2Delegate?.disableCell(status: scheduleOnOffStatus)
        }
    }
}

//MARK: - DayOnOffCell
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
    var dayArray: [String] = []
    
    var dayOnOffCellDelegate: DayOnOffCellDelegate?
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func dayOnOff(_ sender: UIButton) {
        var dayState: Bool = false
        var day: UIButton = UIButton()
        var text: String = ""
        
        switch sender.tag {
        case 0:
            dayState = sunOnOff
            day = sun
            text = NSLocalizedString("sun_day", comment: "")
            sunOnOff = buttonOnOff(dayState, day, text)
            print("text = \(text)")
        case 1:
            dayState = monOnOff
            day = mon
            text = NSLocalizedString("mon_day", comment: "")
            monOnOff = buttonOnOff(dayState, day, text)
        case 2:
            dayState = tueOnOff
            day = tue
            text = NSLocalizedString("tues_day", comment: "")
            tueOnOff = buttonOnOff(dayState, day, text)
        case 3:
            dayState = wedOnOff
            day = wed
            text = NSLocalizedString("wed_day", comment: "")
            wedOnOff = buttonOnOff(dayState, day, text)
        case 4:
            dayState = thurOnOff
            day = thur
            text = NSLocalizedString("thurs_day", comment: "")
            thurOnOff = buttonOnOff(dayState, day, text)
        case 5:
            dayState = friOnOff
            day = fri
            text = NSLocalizedString("fri_day", comment: "")
            friOnOff = buttonOnOff(dayState, day, text)
        case 6:
            dayState = satOnOff
            day = sat
            text =  NSLocalizedString("sat_day", comment: "")
            satOnOff = buttonOnOff(dayState, day, text)
        default:
            return
        }
        self.dayOnOffCellDelegate?.selectedDay(dayArray: dayArray)
    }
    
    func buttonOnOff(_ dayState: Bool, _ day: UIButton, _ text: String) -> Bool {
        let word = text.map{String($0)}[0]
        if dayState == false {
            // TODO
            day.setImage(UIImage(named: "\(word).circle.fill.green"), for: .normal)
            dayArray.append(text)
            return true
        } else {
            // TODO
            day.setImage(UIImage(named: "\(word).circle.fill.gray"), for: .normal)
            dayArray.remove(at: dayArray.firstIndex(of: text)!)
            return false
        }
    }
    
    func editDayDefaultSetting(){
        for i in 0...dayArray.count - 1 {
            let text = dayArray[i]
            let word = text.map{String($0)}[0]
            switch text {
            case NSLocalizedString("sun_day", comment: ""):
                setDaysOn(day: sun, word: word)
                sunOnOff = true
            case NSLocalizedString("mon_day", comment: ""):
                setDaysOn(day: mon, word: word)
                monOnOff = true
            case NSLocalizedString("tues_day", comment: ""):
                setDaysOn(day: tue, word: word)
                tueOnOff = true
            case NSLocalizedString("wed_day", comment: ""):
                setDaysOn(day: wed, word: word)
                wedOnOff = true
            case NSLocalizedString("thurs_day", comment: ""):
                setDaysOn(day: thur, word: word)
                thurOnOff = true
            case NSLocalizedString("fri_day", comment: ""):
                setDaysOn(day: fri, word: word)
                friOnOff = true
            case NSLocalizedString("saturday", comment: ""):
                setDaysOn(day: sat, word: word)
                satOnOff = true
            default:
                return
            }
        }
    }
    
    func setDaysOn(day: UIButton, word: String){
        day.setImage(UIImage(named: "\(word).circle.fill.green"), for: .normal)
    }
}

//MARK: - TimeCell
class TimeCell: UITableViewCell {
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var tilde: UILabel!
    
    var defaultStartTime: String = ""
    var defaultEndTime: String = ""
    
    var timeCellDelegate: TimeCellDelegate?
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func startTime(_ sender: UIButton) {
        let picker = startTimePicker!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        defaultStartTime = dateFormatter.string(from: picker.date)
        self.timeCellDelegate?.startTime(time: defaultStartTime)
    }
    
    @IBAction func endTime(_ sender: UIButton) {
        let picker = endTimePicker!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        defaultEndTime = dateFormatter.string(from: picker.date)
        self.timeCellDelegate?.endTime(time: defaultEndTime)
    }
}

//MARK: - CancelCell
class CancelCell: UITableViewCell {
    
    @IBOutlet weak var cancelButton: UIButton!
    
    var cancelCellDelegate: CancelCellDelegate?
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.cancelCellDelegate?.dismissController()
    }
}

//MARK: - DeleteCell
class DeleteCell: UITableViewCell {
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var deleteCellDelegate: DeleteCellDelegate?
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        self.deleteCellDelegate?.deleteCell()
    }
}

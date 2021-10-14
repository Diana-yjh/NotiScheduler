//
//  EditScheduleVC.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/14.
//

import Foundation
import UIKit

protocol EditScheduleVCDelegate {
    func loadUpdatedDataToViewController(data: ScheduleData)
    func editDataFromViewController(indexPath: IndexPath, data: ScheduleData)
    func deleteDataFromViewController(indexPath: IndexPath)
}

class AddScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, OnOffCell2Delegate, DayOnOffCellDelegate, TimeCellDelegate, CancelCellDelegate, DeleteCellDelegate {
    
    @IBOutlet weak var addScheduleTable: UITableView!
    @IBOutlet weak var viewTitle: UILabel!
    
    var editScheduleVCDelegate: EditScheduleVCDelegate?
    
    public var name: String = "Schedule1"
    public var onOffSwitch: Bool = true
    public var dayArray: [String] = []
    public var startTime: String = "12:00 PM"
    public var endTime: String = "12:00 PM"
    public var checkIfAddOrEdit: Int = 0 //0: Edit, 1: Add
    public var scheduleCount: Int = 0
    public var indexPath: IndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addScheduleTable.tableFooterView = UIView()
        addScheduleTable.rowHeight = UITableView.automaticDimension
        addScheduleTable.delegate = self
        addScheduleTable.dataSource = self
        viewTitle.text = checkIfAddOrEdit == 0 ? NSLocalizedString("edit", comment: "") : NSLocalizedString("add", comment: "")
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 20
    }
    
    func editNameAlert() {
        let alert = UIAlertController(title: NSLocalizedString("edit", comment: ""), message: NSLocalizedString("edit_schedule_name", comment: ""), preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField {(myTextField) in
            myTextField.placeholder = self.name
            myTextField.delegate = self
        }
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .default))
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) {(action) -> Void in
            if let text = alert.textFields?[0].text {
                self.name = text
                let indexPath = [IndexPath(row: 0, section: 0)]
                self.addScheduleTable.reloadRows(at: indexPath, with: .none)
            }
        })
        present(alert, animated: true, completion: nil)
    }
    func selectedDay(dayArray: [String]) {
        self.dayArray = dayArray
        let week = DateFormatter().shortWeekdaySymbols!
        self.dayArray.sort { week.firstIndex(of:  $0)! < week.firstIndex(of: $1)! }
    }
    func startTime(time: String) {
        self.startTime = time
    }
    func endTime(time: String) {
        self.endTime = time
    }
    func dismissController() {
        navigationController?.popViewController(animated: true)
    }
    func deleteCell(){
        let alert = UIAlertController(title: NSLocalizedString("delete_schedule", comment: ""), message: NSLocalizedString("schedule_delete_message", comment: ""), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .default))
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default){(action) -> Void in
            self.editScheduleVCDelegate?.deleteDataFromViewController(indexPath: self.indexPath)
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backToSchedule(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveScheduleButton(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString("save_schedule", comment: ""), message: NSLocalizedString("schedule_save_message", comment: ""), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .default))
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default){(action) -> Void in
            if self.dayArray.count == 0 {
                let alert = UIAlertController(title: NSLocalizedString("save_error", comment: ""), message: NSLocalizedString("schedule_days_error_message", comment: ""), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default))
                self.present(alert, animated:  true, completion: nil)
                return
            }
            
            if self.startTime == self.endTime {
                let alert = UIAlertController(title: NSLocalizedString("save_error", comment: ""), message: NSLocalizedString("schedule_times_error_message", comment: ""), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let data = ScheduleData(name: self.name, onOff: self.onOffSwitch, day: self.dayArray, startTime: self.startTime, endTime: self.endTime)
            self.navigationController?.popViewController(animated: true)
            
            if self.checkIfAddOrEdit == 1 {
                self.editScheduleVCDelegate?.loadUpdatedDataToViewController(data: data)
            } else {
                self.editScheduleVCDelegate?.editDataFromViewController(indexPath: self.indexPath, data: data)
            }
        })
        present(alert, animated: true, completion: nil)
    }
    
    func disableCell(status: Bool) {
        onOffSwitch = status
        self.addScheduleTable.reloadData()
    }
    
    func dayOnOffCellUserInteraction(cell: DayOnOffCell, alpha: CGFloat){
        cell.sun.alpha = alpha
        cell.mon.alpha = alpha
        cell.tue.alpha = alpha
        cell.wed.alpha = alpha
        cell.thur.alpha = alpha
        cell.fri.alpha = alpha
        cell.sat.alpha = alpha
        cell.isUserInteractionEnabled = onOffSwitch
    }
    
    func timeCellUserInteraction(cell: TimeCell, alpha: CGFloat){
        cell.startTimePicker.alpha = alpha
        cell.endTimePicker.alpha = alpha
        cell.tilde.alpha = alpha
        cell.startTimeLabel.alpha = alpha
        cell.endTimeLabel.alpha = alpha
        cell.isUserInteractionEnabled = onOffSwitch
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkIfAddOrEdit == 1{
            return 3
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnOffCell2") as! OnOffCell2
            cell.scheduleName.setTitle(name, for: .normal)
            onOffSwitch == true ? cell.scheduleOnOff.setImage(UIImage(named: "Switch_on"), for: .normal) : cell.scheduleOnOff.setImage(UIImage(named: "Switch_off"), for: .normal)
            cell.scheduleOnOffStatus = onOffSwitch
            cell.onOffCell2Delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayOnOffCell") as! DayOnOffCell
            onOffSwitch == false ? dayOnOffCellUserInteraction(cell: cell, alpha: 0.2) : dayOnOffCellUserInteraction(cell: cell, alpha: 1)
            cell.dayArray = dayArray
            if checkIfAddOrEdit == 0 {
                cell.editDayDefaultSetting()
            }
            cell.dayOnOffCellDelegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell") as! TimeCell
            onOffSwitch == false ? timeCellUserInteraction(cell: cell, alpha: 0.2) : timeCellUserInteraction(cell: cell, alpha: 1)
            if checkIfAddOrEdit == 0 {
                let sTime = startTime
                let eTime = endTime
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                let sDate = dateFormatter.date(from: sTime)!
                let eDate = dateFormatter.date(from: eTime)!
                cell.startTimePicker.date = sDate
                cell.endTimePicker.date = eDate
            }
            cell.timeCellDelegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteCell") as! DeleteCell
            cell.deleteCellDelegate = self
            return cell
        }
    }
    
    //cell 눌렀을 때 회색박스 안생기게
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        switch row {
        case 0:
            return 80
        case 1:
            return 60
        case 2:
            return 150
        case 3:
            return 40
        default:
            return 80
        }
    }
}

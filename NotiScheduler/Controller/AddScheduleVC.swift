//
//  EditScheduleVC.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/14.
//

import Foundation
import UIKit

protocol AddScheduleVCDelegate {
    func sendDataToViewController(data: ScheduleData)
}

class AddScheduleVC: UIViewController, UITableViewDataSource, UITableViewDelegate, OnOffCell2Delegate, DayOnOffCellDelegate, TimeCellDelegate, CancelCellDelegate, DeleteCellDelegate {
    
    @IBOutlet weak var addScheduleTable: UITableView!
    @IBOutlet weak var viewTitle: UILabel!
    
    var addScheduleVCDelegate: AddScheduleVCDelegate?
    
    public var scheduleName: String = "Schedule1"
    public var editScheduleOnOffSwitch: Bool = true
    public var dayArray: [String] = []
    public var startTime: String = "12:00"
    public var endTime: String = "12:00"
    public var buttonForShowingAddView: Int = 0
    public var scheduleCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addScheduleTable.tableFooterView = UIView()
        addScheduleTable.rowHeight = UITableView.automaticDimension
        addScheduleTable.delegate = self
        addScheduleTable.dataSource = self
        
        if buttonForShowingAddView == 0 {
            viewTitle.text = "Edit"
        } else {
            viewTitle.text = "Add"
        }
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Delegate functions
    func showAlert() {
        let alert = UIAlertController(title: "Edit", message: "Edit schedule name.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField {(myTextField) in
            myTextField.placeholder = self.scheduleName
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "OK", style: .default) {(action) -> Void in
            if let text = alert.textFields?[0].text {
                self.scheduleName = text
                let indexPath = [IndexPath(row: 0, section: 0)]
                self.addScheduleTable.reloadRows(at: indexPath, with: .none)
            }
        })
        present(alert, animated: true, completion: nil)
    }
    func selectedDay(dayArray: [String]) {
        self.dayArray = dayArray
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
        let alert = UIAlertController(title: "Delete Schedule", message: "Do you want to delete the schedule?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Ok", style: .default){(action) -> Void in
            
        })
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backToSchedule(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveScheduleButton(_ sender: Any) {
        let alert = UIAlertController(title: "Save Schedule", message: "Do you want to save the schedule?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Ok", style: .default){(action) -> Void in
            if self.dayArray.count == 0 {
                let alert = UIAlertController(title: "Save Error", message: "Select the schedule day", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated:  true, completion: nil)
                return
            }
            let data = ScheduleData(name: self.scheduleName, onOff: self.editScheduleOnOffSwitch, day: self.dayArray, startTime: self.startTime, endTime: self.endTime)
            self.navigationController?.popViewController(animated: true)
            self.addScheduleVCDelegate?.sendDataToViewController(data: data)
        })
        present(alert, animated: true, completion: nil)
    }
    
    func disableCell(status: Bool) {
        editScheduleOnOffSwitch = status
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
        cell.isUserInteractionEnabled = editScheduleOnOffSwitch
    }
    
    func timeCellUserInteraction(cell: TimeCell, alpha: CGFloat){
        cell.startTimePicker.alpha = alpha
        cell.endTimePicker.alpha = alpha
        cell.tilde.alpha = alpha
        cell.startTimeLabel.alpha = alpha
        cell.endTimeLabel.alpha = alpha
        cell.isUserInteractionEnabled = editScheduleOnOffSwitch
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if buttonForShowingAddView == 1{
                return 3
            } else {
                return 4
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnOffCell2") as! OnOffCell2
            cell.scheduleName.setTitle(scheduleName, for: .normal)
            
            if editScheduleOnOffSwitch == true {
                cell.scheduleOnOff.setImage(UIImage(named: "switch_on"), for: .normal)
            } else {
                cell.scheduleOnOff.setImage(UIImage(named: "switch_off"), for: .normal)
            }
            
            cell.onOffCell2Delegate = self
            return cell
        } else if row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayOnOffCell") as! DayOnOffCell
            
            if editScheduleOnOffSwitch == false {
                dayOnOffCellUserInteraction(cell: cell, alpha: 0.2)
            } else {
                dayOnOffCellUserInteraction(cell: cell, alpha: 1)
            }
            cell.dayOnOffCellDelegate = self
            return cell
        } else if row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell") as! TimeCell
            
            if editScheduleOnOffSwitch == false {
                timeCellUserInteraction(cell: cell, alpha: 0.2)
            } else {
                timeCellUserInteraction(cell: cell, alpha: 1)
            }
            cell.timeCellDelegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteCell") as! DeleteCell
            return cell
        }
    }
    
    
    //cell 눌렀을 때 회색박스 안생기게
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        if row == 1 || row == 3 {
            return 40
        } else if row == 2 {
            return 150
        } else {
            return 80
        }
    }
}

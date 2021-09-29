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

class AddScheduleVC: UIViewController, UITableViewDataSource, UITableViewDelegate, OnOffCell2Delegate, DayOnOffCellDelegate, TimeCellDelegate, CancelCellDelegate {
    
    @IBOutlet weak var addScheduleTable: UITableView!
    
    public var scheduleName: String = "스케줄 이름"
    public var editScheduleOnOff: Bool = true
    public var dayArray: [String] = []
    public var startTime: String = ""
    public var endTime: String = ""
    
    var addScheduleVCDelegate: AddScheduleVCDelegate?
    
    func showAlert() {
        let alert = UIAlertController(title: "스케줄 이름 변경", message: "8글자 내로 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField {(myTextField) in
            myTextField.placeholder = self.scheduleName
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default) {(action) -> Void in
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
    //스케줄 추가 화면의 취소버튼
    func dismissController() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveScheduleButton(_ sender: Any) {
        let alert = UIAlertController(title: "스케줄 저장", message: "저장하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default){(action) -> Void in
            
            let vc = self.storyboard!.instantiateViewController(identifier: "ViewController") as! ViewController
            let data = ScheduleData(name: self.scheduleName, onOff: self.editScheduleOnOff, day: self.dayArray, startTime: self.startTime, endTime: self.endTime)
            print(vc.count)
            self.navigationController?.popViewController(animated: true)
            self.addScheduleVCDelegate?.sendDataToViewController(data: data)
        })
        present(alert, animated: true, completion: nil)
    }
    
    func disableCell(status: Bool) {
        editScheduleOnOff = status
        if editScheduleOnOff == false {
            self.addScheduleTable.reloadData()
        } else {
            self.addScheduleTable.reloadData()
        }
    }
    
    func dayOnOffCellUserInteraction(cell: DayOnOffCell, alpha: CGFloat){
        cell.sun.alpha = alpha
        cell.mon.alpha = alpha
        cell.tue.alpha = alpha
        cell.wed.alpha = alpha
        cell.thur.alpha = alpha
        cell.fri.alpha = alpha
        cell.sat.alpha = alpha
        cell.isUserInteractionEnabled = editScheduleOnOff
    }
    
    func timeCellUserInteraction(cell: TimeCell, alpha: CGFloat){
        cell.startTimePicker.alpha = alpha
        cell.endTimePicker.alpha = alpha
        cell.tilde.alpha = alpha
        cell.startTimeLabel.alpha = alpha
        cell.endTimeLabel.alpha = alpha
        cell.isUserInteractionEnabled = editScheduleOnOff
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addScheduleTable.tableFooterView = UIView()
        addScheduleTable.rowHeight = UITableView.automaticDimension
        addScheduleTable.delegate = self
        addScheduleTable.dataSource = self
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @IBAction func cancelScheduleButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnOffCell2") as! OnOffCell2
            cell.scheduleName.setTitle(scheduleName, for: .normal)
            cell.onOffCell2Delegate = self
            print("self = \(self)")
            return cell
        } else if row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayOnOffCell") as! DayOnOffCell
            
            if editScheduleOnOff == false {
                dayOnOffCellUserInteraction(cell: cell, alpha: 0.2)
            } else {
                dayOnOffCellUserInteraction(cell: cell, alpha: 1)
            }
            cell.dayOnOffCellDelegate = self
            return cell
        } else if row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell") as! TimeCell
            
            if editScheduleOnOff == false {
                timeCellUserInteraction(cell: cell, alpha: 0.2)
            } else {
                timeCellUserInteraction(cell: cell, alpha: 1)
            }
            cell.timeCellDelegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CancelCell") as! CancelCell
            cell.cancelCellDelegate = self
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

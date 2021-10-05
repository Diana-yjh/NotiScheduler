//
//  ViewController.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/09.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddScheduleVCDelegate {
    @IBOutlet weak var scheduleTableView: UITableView!
    @IBOutlet weak var onOffSwitch: UIButton!
    
    //    public var onOffButtonStatus: Bool = true
    public var onOffButtonStatus: String = "y"
    public var scheduleStatus: Bool = true
    public var count: Int = 0
    public var receiveData: [ScheduleData] = []
    public var buttonForShowingAddView: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        scheduleTableView.tableFooterView = UIView()
        scheduleTableView.rowHeight = UITableView.automaticDimension
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
    }
    
    //navigation bar 이전 화면으로 돌아왔을 때 title 삭제되는 것을 방지하기 위함
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Schedule"
        let addScheduleVC: AddScheduleVC = storyboard?.instantiateViewController(identifier: "AddScheduleVC") as! AddScheduleVC
        addScheduleVC.addScheduleVCDelegate = self
        scheduleTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addScheduleVC: AddScheduleVC = segue.destination as! AddScheduleVC
        addScheduleVC.addScheduleVCDelegate = self
    }
    
    func sendDataToViewController(data: ScheduleData) {
        self.receiveData.append(data)
        count += 1
    }
    
    @IBAction func showAddSchedule(_ sender: Any) {
        buttonForShowingAddView = 1
        if let vc = storyboard?.instantiateViewController(identifier: "AddScheduleVC") as? AddScheduleVC {
            vc.buttonForShowingAddView = self.buttonForShowingAddView
            vc.addScheduleVCDelegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func sendDataToServer(_ sender: Any) {
        var sendJsonData = ["use_all": onOffButtonStatus, "schedules": []] as [String : Any]
        var dataArray: [Any] = []
        
        if count == 0 { return }
        
        for i in 0...count-1 {
            let name = self.receiveData[i].name
            let use = self.receiveData[i].onOff ? "y" : "n"
            let day = self.receiveData[i].day.joined(separator: ",")
            let start = self.receiveData[i].startTime
            let end = self.receiveData[i].endTime
            
            let param = ["name":name, "use": use, "day": day, "start": start, "end": end] as [String : Any]
            if let theJSONData = try? JSONSerialization.data(withJSONObject: param, options: []) {
                let theJSONText = String(data: theJSONData, encoding: .utf8)
                dataArray.append(theJSONText!)
            }
            sendJsonData.updateValue(dataArray, forKey: "schedules")
            
            if let jsonResult = try? JSONSerialization.data(withJSONObject: sendJsonData, options: []) {
                let theJSONText = String(data: jsonResult, encoding: .utf8)
                
                print("theJSONText = \(theJSONText!)")
            }
        }
    }
    
    @IBAction func onOffSwitch(_ sender: Any) {
        if scheduleStatus == true {
            self.onOffButtonStatus = "n"
            onOffSwitch.setImage(UIImage(named: "switch_off"), for: .normal)
            scheduleStatus = false
        } else {
            self.onOffButtonStatus = "y"
            onOffSwitch.setImage(UIImage(named: "switch_on"), for: .normal)
            scheduleStatus = true
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! ScheduleCell
            print(indexPath)
            cell.scheduleName.text = receiveData[indexPath.row].name
            cell.time.text = "\(receiveData[indexPath.row].startTime) ~ \(receiveData[indexPath.row].endTime)"
            cell.day.text = receiveData[indexPath.row].day.joined(separator: ", ")
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell")
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cell 눌럿을 때 회색박스 안생기게
        tableView.deselectRow(at: indexPath, animated: true)
        if let addScheduleVC = storyboard?.instantiateViewController(identifier: "AddScheduleVC") as? AddScheduleVC {
            addScheduleVC.scheduleName = receiveData[indexPath.row].name
            addScheduleVC.editScheduleOnOffSwitch = receiveData[indexPath.row].onOff
            addScheduleVC.startTime = receiveData[indexPath.row].startTime
            addScheduleVC.endTime = receiveData[indexPath.row].endTime
            navigationController?.pushViewController(addScheduleVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func deleteRow(){
        
    }
    
//    왼쪽으로 밀어서 행 삭제
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    {
//        let DeleteAction = UIContextualAction(style: .destructive, title:  "삭제", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            self.count -= 1
//            self.receiveData.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            print("Delete")
//            success(true)
//        })
//        DeleteAction.backgroundColor = .red
//
//        let OffAction = UIContextualAction(style: .normal, title:  "끄기", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            print("On/Off")
//            success(true)
//        })
//        OffAction.backgroundColor = .gray
//        return UISwipeActionsConfiguration(actions: [DeleteAction,OffAction])
//    }
}

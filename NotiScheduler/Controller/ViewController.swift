//
//  ViewController.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/09.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddScheduleVCDelegate {
    @IBOutlet weak var scheduleTableView: UITableView!
    
    public var onOffButtonStatus: Bool = true
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
        self.navigationItem.title = "스케줄"
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
        navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        switch section {
        case 0:
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OnOffCell")
                return cell!
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SchedulebarCell")
                return cell!
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! ScheduleCell
            print(indexPath)
            cell.scheduleName.text = receiveData[indexPath.row].name
            cell.time.text = "\(receiveData[indexPath.row].startTime) ~ \(receiveData[indexPath.row].endTime)"
            cell.day.text = receiveData[indexPath.row].day.reduce(""){ return $0 + " " + $1 }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell")
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "Schedules"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cell 눌럿을 때 회색박스 안생기게
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = indexPath.section
        if section == 1 {
            print("section is selected = \(indexPath.row)")
            if let addScheduleVC = storyboard?.instantiateViewController(identifier: "AddScheduleVC") as? AddScheduleVC {
                addScheduleVC.scheduleName = receiveData[indexPath.row].name
                addScheduleVC.dayArray = receiveData[indexPath.row].day
                addScheduleVC.startTime = receiveData[indexPath.row].startTime
                addScheduleVC.endTime = receiveData[indexPath.row].endTime
                navigationController?.pushViewController(addScheduleVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        let row = indexPath.row
        
        switch section {
        case 0:
            if row == 0 {
                return 80
            } else {
                return 250
            }
        case 1:
            return 80
        default:
            return 0
        }
    }
    
//    왼쪽으로 밀어서 행 삭제
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
        {
            let section = indexPath.section
            if section == 1 {
                let DeleteAction = UIContextualAction(style: .destructive, title:  "삭제", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                    self.count -= 1
                    self.receiveData.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    print("Delete")
                    success(true)
                })
                DeleteAction.backgroundColor = .red
    
                let OffAction = UIContextualAction(style: .normal, title:  "끄기", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                    print("On/Off")
                    success(true)
                })
                OffAction.backgroundColor = .gray
                return UISwipeActionsConfiguration(actions: [DeleteAction,OffAction])
            } else {
                return nil
            }
        }
}

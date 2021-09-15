//
//  ViewController.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/09.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var scheduleTableView: UITableView!
    
    public var status: Bool = false
    public var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleTableView.tableFooterView = UIView()
        scheduleTableView.rowHeight = UITableView.automaticDimension
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        print("called")
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell")
            return cell!
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
    
    //왼쪽으로 밀어서 행 삭제
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let section = indexPath.section
        
        if section == 1 {
            let DeleteAction = UIContextualAction(style: .destructive, title:  "삭제", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
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

//
//  EditScheduleVC.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/14.
//

import Foundation
import UIKit

class EditScheduleVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var editScheduleTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editScheduleTable.tableFooterView = UIView()
        editScheduleTable.rowHeight = UITableView.automaticDimension
        editScheduleTable.delegate = self
        editScheduleTable.dataSource = self
    }
    
    @IBAction func toPreviousView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("called")
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnOffCell")
            return cell!
        } else if row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleNameCell")
            return cell!
        } else if row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayOnOffCell")
            return cell!
        } else if row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell")
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteCell")
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        
        if row == 2 || row == 4 {
            return 40
        } else if row == 3 {
            return 150
        } else {
            return 80
        }
    }
}

//
//  ViewController.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/09.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var scheduleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleTableView.estimatedRowHeight = 100
        scheduleTableView.rowHeight = UITableView.automaticDimension
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "")
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "OnOffCell")
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "SchedulebarCell")
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        } else {
            return UITableView.automaticDimension
        }
    }
}

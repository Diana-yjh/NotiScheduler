//
//  editScheduleVC.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/23.
//

import Foundation
import UIKit

class EditScheduleVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var editScheduleTable: UITableView!
    
    public var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editScheduleTable.tableFooterView = UIView()
        editScheduleTable.rowHeight = UITableView.automaticDimension
        editScheduleTable.delegate = self
        editScheduleTable.dataSource = self
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func deleteScheduleButton(_ sender: Any) {
        count -= 1
        let viewController = ViewController()
        viewController.count = self.count
        self.dismiss(animated: true, completion: nil)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnOffCell3")
            return cell!
        } else if row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayOnOffCell2")
            return cell!
        } else if row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell2")
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteCell")
            return cell!
        }
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


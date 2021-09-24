//
//  EditScheduleVC.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/14.
//

import Foundation
import UIKit

class AddScheduleVC: UIViewController, UITableViewDataSource, UITableViewDelegate, OnOffCell2Delegate {
    func showAlert(scheduleName: String) {
        print("showAlert called")
        let alert = UIAlertController(title: "스케줄 이름 변경", message: "변경할 이름을 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (myTextField) in
            myTextField.placeholder = scheduleName
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default) {(action) -> Void in
            if let text = alert.textFields?[0].text {
                print("text = \(text)")
            }
        })
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var addScheduleTable: UITableView!
    
    public var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addScheduleTable.tableFooterView = UIView()
        addScheduleTable.rowHeight = UITableView.automaticDimension
        addScheduleTable.delegate = self
        addScheduleTable.dataSource = self
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func cancelScheduleButton(_ sender: Any) {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnOffCell2") as! OnOffCell2
            cell.delegate = self
            return cell
        } else if row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayOnOffCell")
            return cell!
        } else if row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell")
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CancelCell")
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

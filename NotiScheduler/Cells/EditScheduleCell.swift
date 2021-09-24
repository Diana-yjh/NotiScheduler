//
//  editScheduleCell.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/23.
//

import Foundation
import UIKit

class OnOffCell3: UITableViewCell {
    
    @IBOutlet weak var scheduleName: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func editScheduleName(_ sender: Any) {
        showAlert()
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "이름 변경", message: "스케줄 이름을 변경합니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addTextField { (myTextField) in
            myTextField.placeholder = "이름"
        }
    }
}

class DayOnOffCell2: UITableViewCell {
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func dayOnOff(_ sender: Any) {
//        var sunStatus = true
//        var monStatus = true
//        var tueStatus = true
//        var wedStatus = true
//        var thurStatus = true
//        var friStatus = true
//        var satStatus = true
        
        print("sender = \(sender)")
    }
}

class TimeCell2: UITableViewCell {
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
}

class DeleteCell: UITableViewCell {
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
}

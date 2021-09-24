//
//  ManagerCell.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/15.
//

import Foundation
import UIKit

protocol OnOffCell2Delegate {
    func showAlert()
}

//extension OnOffCell2: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSeletedItemAt indexPath: IndexPath) {
//        if let delegate = delegate {
//            delegate.showAlert()
//        }
//    }
//}

class OnOffCell2: UITableViewCell {
    
    @IBOutlet weak var scheduleName: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var delegate: OnOffCell2Delegate?
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func editScheduleNameButton(_ sender: Any) {
        print("called")
        self.delegate?.showAlert()
    }
}

class DayOnOffCell: UITableViewCell {
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func dayOnOff(_ sender: Any) {
        
        print("sender = \(sender)")
    }
}

class TimeCell: UITableViewCell {
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
}

class CancelCell: UITableViewCell {
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
}

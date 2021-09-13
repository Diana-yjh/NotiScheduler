//
//  TableViewCell.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/10.
//

import Foundation
import UIKit

class OnOffCell: UITableViewCell {
    
    @IBOutlet weak var scheduleOnOffLabel: UILabel!
    @IBOutlet weak var scheduleOnOffButton: UISwitch!
    
    override func layoutSubviews(){
        super.layoutSubviews()
        scheduleOnOffLabel.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
//        scheduleOnOffButton.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
    }
}

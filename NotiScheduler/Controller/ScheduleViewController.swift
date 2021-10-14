//
//  ViewController.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/09.
//

import UIKit

@objc class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EditScheduleVCDelegate, SchedulebCellDelegate {
    @IBOutlet weak var scheduleTableView: UITableView!
    @IBOutlet weak var onOffSwitch: UIButton!
    
    //    public var onOffButtonStatus: Bool = true
    public var mainOnOffStatus: String = "y"
    public var eachScheduleOnOffStatus: Bool = true
    public var totalScheduleCount: Int = 0
    public var storedScheduleData: [ScheduleData] = []
    @IBOutlet weak var defaultBackgroundLabel: UILabel!
    public var camId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        //for removing unnecessary tableview lines
        scheduleTableView.tableFooterView = UIView()
        //to customize tableview's height
        scheduleTableView.rowHeight = UITableView.automaticDimension
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        
//        loadSchedule()
    }
    
    //to maintain the title
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Schedule"
        scheduleTableView.reloadData()
        
        if totalScheduleCount != 0 {
            defaultBackgroundLabel.isHidden = true
        } else {
            defaultBackgroundLabel.isHidden = false
        }
    }
    
    func loadUpdatedDataToViewController(data: ScheduleData) {
        self.storedScheduleData.append(data)
        totalScheduleCount += 1
    }
    func editDataFromViewController(indexPath: IndexPath, data: ScheduleData) {
        self.storedScheduleData[indexPath.row] = data
    }
    func deleteDataFromViewController(indexPath: IndexPath) {
        totalScheduleCount -= 1
        self.storedScheduleData.remove(at: indexPath.row)
        scheduleTableView.deleteRows(at: [indexPath], with: .none)
    }
    
    func onOffControllInMain(onOffStatus: Bool, index: IndexPath) {
        self.storedScheduleData[index.row].onOff = onOffStatus
        print(self.storedScheduleData[index.row].onOff)
        print("called")
    }
    
    func timeConversion12to24(time12: String) -> String {
        let dateAsString = time12
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "HH:mm"
        
        let time24 = dateFormatter.string(from: date!)
        print(time24)
        return time24
    }
    
    func timeConversion24to12(time24: String) -> String {
        let dateAsString = time24
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "hh:mm a"
        
        let time12 = dateFormatter.string(from: date!)
        return time12
    }
    
    @IBAction func showAddSchedule(_ sender: Any) {
        
        if totalScheduleCount > 14 {
            let alert = UIAlertController(title: NSLocalizedString("schedule_error", comment: ""), message: NSLocalizedString("schedule_add_error_message", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .default))
            alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddScheduleViewController") as? AddScheduleViewController {
            vc.checkIfAddOrEdit = 1
            vc.editScheduleVCDelegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func sendDataToServer(_ sender: Any) {
        var sendJsonData = ["use_all": mainOnOffStatus, "schedules": []] as [String : Any]
        var dataArray: [Any] = []
        
        if totalScheduleCount > 0 {
            for i in 0...totalScheduleCount-1 {
                let name = self.storedScheduleData[i].name
                let use = self.storedScheduleData[i].onOff ? "y" : "n"
                let day = self.storedScheduleData[i].day.map{$0.lowercased()}.joined(separator: ",")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                
                let start = self.storedScheduleData[i].startTime
                let end = self.storedScheduleData[i].endTime
                
                print("startTime: \(start), endTime: \(end)")
                let param = ["name":name, "use": use, "day": day, "start": timeConversion12to24(time12: start), "end": timeConversion12to24(time12: end)] as [String : Any]
                
                print("param = \(param)")
                }
            }
        
//        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onOffSwitch(_ sender: Any) {
        if eachScheduleOnOffStatus == true {
            self.mainOnOffStatus = "n"
            onOffSwitch.setImage(UIImage(named: "Switch_off"), for: .normal)
            eachScheduleOnOffStatus = false
        } else {
            self.mainOnOffStatus = "y"
            onOffSwitch.setImage(UIImage(named: "Switch_on"), for: .normal)
            eachScheduleOnOffStatus = true
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return totalScheduleCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! ScheduleCell
            cell.scheduleName.text = storedScheduleData[indexPath.row].name
            cell.time.text = "\(storedScheduleData[indexPath.row].startTime) ~ \(storedScheduleData[indexPath.row].endTime)"
            cell.day.text = storedScheduleData[indexPath.row].day.joined(separator: ", ")
            cell.onOffStatus = storedScheduleData[indexPath.row].onOff
            cell.onOffScheduleInMain(storedScheduleData[indexPath.row].onOff)
            cell.index = indexPath
            cell.scheduleCellDelegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell")
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cell 눌럿을 때 회색박스 안생기게
        tableView.deselectRow(at: indexPath, animated: true)
        if let addScheduleVC = storyboard?.instantiateViewController(withIdentifier: "AddScheduleViewController") as? AddScheduleViewController {
            addScheduleVC.checkIfAddOrEdit = 0
            addScheduleVC.name = storedScheduleData[indexPath.row].name
            addScheduleVC.onOffSwitch = storedScheduleData[indexPath.row].onOff
            print("storedScheduleData[indexPath.row].onOff = \(storedScheduleData[indexPath.row].onOff)")
            addScheduleVC.dayArray = storedScheduleData[indexPath.row].day
            addScheduleVC.startTime = storedScheduleData[indexPath.row].startTime
            addScheduleVC.endTime = storedScheduleData[indexPath.row].endTime
            addScheduleVC.indexPath = indexPath
            addScheduleVC.editScheduleVCDelegate = self;

            navigationController?.pushViewController(addScheduleVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    /* MARK: 왼쪽으로 밀어서 행 삭제
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let DeleteAction = UIContextualAction(style: .destructive, title:  "삭제", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.totalScheduleCount -= 1
                       self.storedScheduleData.remove(at: indexPath.row)
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
    }
     */
    
    
    
//
    @objc func setCamId(_ id: String) {
        camId = id
        NSLog("camId : \(String(describing: camId!))")
    }

//    서버에서 가져온 데이터 UI에 뿌려주기
//    func loadSchedule() {
//        let app = UIApplication.shared.delegate as! AppDelegate
//        let openApi = app.getOpenApi()
//        if openApi == nil || camId == nil {
//            return
//        }

//      [ApplicationDelegate showProgress2:self msg:nil];
//        let code = openApi?.reqScheduleLoad(camId)
//        if code == 0 {
////            [ApplicationDelegate dismissProgress];
//            let useAll = openApi?.get_schedule_use_all()
//           NSLog("use_all: \(String(describing: useAll))")
//
//            let list = openApi?.getScheduleInfoList()
//            for item in list! as! [[String:Any]] {
//                let name = item["name"] as! String
//                let use = item["use"] as! String
//                let day = item["day"] as! String
//                let start = item["start"] as! String
//                let end = item["end"] as! String
//                NSLog("name: \(name) use: \(use) day: \(day) start: \(start) end: \(end) ")
//
//                let dayList = day.components(separatedBy: ",")
//                let onOff = (use == "y") ? true : false
//                let data = ScheduleData(name:name, onOff:onOff, day:dayList, startTime:start, endTime:end)
//                loadUpdatedDataToViewController(data: data)
//            }
//        }
//        else {
            /*
            [ApplicationDelegate dismissProgress];

            int http_response_code = [OA getHttpResponseCode];
            if (http_response_code == HTTP_OK) {
              [ApplicationDelegate
                  Popup_MessageBox_OK_Wait:self
                                     title:nil
                                       msg:[NSString stringWithFormat:@"%@ w:%d",
                                                                      common_try_again,
                                                                      code]];
            } else if (http_response_code == HTTP_NULL) {
              [ApplicationDelegate Popup_MessageBox_OK_Wait:self
                                                      title:nil
                                                        msg:common_check_your_network];
            } else {
              [ApplicationDelegate
                  Popup_MessageBox_OK_Wait:self
                                     title:nil
                                       msg:[NSString
                                               stringWithFormat:@"%@ h:%d",
                                                                common_try_again,
                                                                http_response_code]];
            }
             */
//        }
//    }

    //UI에 보이는 데이터들 서버에 저장하기
//    func saveSchedule() {
//        let app = UIApplication.shared.delegate as! AppDelegate
//        let openApi = app.getOpenApi()
//        if openApi == nil || camId == nil {
//            return
//        }
//
//        let use_all = "y"
//        let schedules: [[String: AnyObject]] = []
//
//        // TODO fill schedules / (NSMutableArray *)schedules
//        let code = openApi?.reqScheduleSave(camId, use_all:use_all, schedules: schedules)
//        if code == 0 {
            
        /*  MARK: 하드코딩된 데이터
            NSString *use_all = @"y";
            
            NSMutableArray *schedules = [[NSMutableArray alloc] init];
            
            NSMutableDictionary *info1 = [[NSMutableDictionary alloc] init];
            [info1 setValue:@"morning" forKey:@"name"];
            [info1 setValue:@"y" forKey:@"use"];
            [info1 setValue:@"mon,tue" forKey:@"day"];
            [info1 setValue:@"08:00" forKey:@"start"];
            [info1 setValue:@"14:00" forKey:@"end"];
            [schedules addObject:info1];
            info1 = nil;

            NSMutableDictionary *info2 = [[NSMutableDictionary alloc] init];
            [info2 setValue:@"evening" forKey:@"name"];
            [info2 setValue:@"n" forKey:@"use"];
            [info2 setValue:@"thu,fri,sat" forKey:@"day"];
            [info2 setValue:@"13:00" forKey:@"start"];
            [info2 setValue:@"18:00" forKey:@"end"];
            [schedules addObject:info2];
            info2 = nil;

            NSMutableDictionary *info3 = [[NSMutableDictionary alloc] init];
            [info3 setValue:@"shut down" forKey:@"name"];
            [info3 setValue:@"y" forKey:@"use"];
            [info3 setValue:@"sat,sun" forKey:@"day"];
            [info3 setValue:@"22:00" forKey:@"start"];
            [info3 setValue:@"07:00" forKey:@"end"];
            [schedules addObject:info3];
            info3 = nil;
         */
            
            //[ApplicationDelegate showProgress2:self msg:nil];
       
            //[ApplicationDelegate dismissProgress];
            
        }
//        else {
            /*
            [ApplicationDelegate dismissProgress];

            int http_response_code = [OA getHttpResponseCode];
            if (http_response_code == HTTP_OK) {
              [ApplicationDelegate
                  Popup_MessageBox_OK_Wait:self
                                     title:nil
                                       msg:[NSString stringWithFormat:@"%@ w:%d",
                                                                      common_try_again,
                                                                      code]];
            } else if (http_response_code == HTTP_NULL) {
              [ApplicationDelegate Popup_MessageBox_OK_Wait:self
                                                      title:nil
                                                        msg:common_check_your_network];
            } else {
              [ApplicationDelegate
                  Popup_MessageBox_OK_Wait:self
                                     title:nil
                                       msg:[NSString
                                               stringWithFormat:@"%@ h:%d",
                                                                common_try_again,
                                                                http_response_code]];
            }
             */
//        }
//    }
//}

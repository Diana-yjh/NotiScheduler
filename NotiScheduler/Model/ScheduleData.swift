//
//  ScheduleData.swift
//  NotiScheduler
//
//  Created by Yejin Hong on 2021/09/27.
//

import Foundation

struct ScheduleData {
    var name: String
    var onOff: Bool
    var day: Day
    var time: Time
}

struct Day {
    var mon: Bool
    var tue: Bool
    var wed: Bool
    var thu: Bool
    var fri: Bool
    var sat: Bool
    var sun: Bool
}

struct Time {
    var startTime: Date
    var endTime: Date
}

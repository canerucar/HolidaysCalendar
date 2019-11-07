//
//  Holiday.swift
//  HolidayCalendar
//
//  Created by Caner Uçar on 7.11.2019.
//  Copyright © 2019 Caner Uçar. All rights reserved.
//

import Foundation

struct HolidayResponse:Decodable {
    var response : Holidays
}

struct Holidays:Decodable {
    var holidays : [HolidayDetail]
}

struct HolidayDetail:Decodable {
    var name : String
    var date : DateInfo
}

struct DateInfo:Decodable {
    var iso : String
}

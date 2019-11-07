//
//  HolidayRequest.swift
//  HolidayCalendar
//
//  Created by Caner Uçar on 7.11.2019.
//  Copyright © 2019 Caner Uçar. All rights reserved.
//

import Foundation

enum HolidayError:Error{
    case noDataAvaible
    case canNotProcessData
}

struct HolidayRequest {
    let resourceURL : URL
    let API_KEY = "3e46a90836e1f20b1e069c1a05ee8023d2f78c5f"
    
    init(countryCode : String) {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    func getHolidays (completion: @escaping(Result<[HolidayDetail], HolidayError>)->Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data,_,_ in
            
            guard let jsonData = data else{
                completion(.failure(.noDataAvaible))
                return
            }
            do{
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidayResponse.response.holidays
                completion(.success(holidayDetails))
            }catch{
                completion(.failure(.canNotProcessData))
            }
            
        }
        dataTask.resume()
    }
}

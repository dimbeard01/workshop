//
//  RewardTimeFormatter.swift
//  Alerts
//
//  Created by Dima on 21.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation

final class RewardTimeFormatter {
    
    func convertedDate(with date: Int) -> String? {
        //Current date
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        let currentDay = calendar.component(.day, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        
        //Last seen date
        let timeResult = Date(timeIntervalSince1970: Double(date))
        let dateFormatter = DateFormatter()
        
        let hourWasOnline = dateFormatter.calendar.component(.hour, from: timeResult)
        let dayWasOnline = dateFormatter.calendar.component(.day, from: timeResult)
        let monthWasOnline = dateFormatter.calendar.component(.month, from: timeResult)
        let yearWasOnline = dateFormatter.calendar.component(.year, from: timeResult)
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let currentDateString = dateFormatter.string(from: currentDate)
        let wasOnlineString = dateFormatter.string(from: timeResult)
        
        if currentDateString == wasOnlineString {
            let today = currentHour - hourWasOnline
            return "\(today)ч."
        } else if (dayWasOnline, monthWasOnline, yearWasOnline) == ((currentDay - 1), currentMonth, currentYear) {
            let yesterday = 24 - hourWasOnline + currentHour
            return "\(yesterday)ч."
        } else {
            return nil
        }
    }
}

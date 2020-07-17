//
//  LastSeenDateFormatter.swift
//  Alerts
//
//  Created by Dima on 16.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation

final class LastSeenDateFormatter {
    
    func convertedDate(with date: Int) -> String? {
        //Current date
        let currentDate = Date()
        let calendar = Calendar.current
        let currentDay = calendar.component(.day, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        
        //Last seen date
        let timeResult = Date(timeIntervalSince1970: Double(date))
        let dateFormatter = DateFormatter()
        let dayWasOnline = dateFormatter.calendar.component(.day, from: timeResult)
        let monthWasOnline = dateFormatter.calendar.component(.month, from: timeResult)
        let yearWasOnline = dateFormatter.calendar.component(.year, from: timeResult)
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let currentDateString = dateFormatter.string(from: currentDate)
        let wasOnlineString = dateFormatter.string(from: timeResult)
        
        if currentDateString == wasOnlineString {
            dateFormatter.dateFormat = "в HH:mm сегодня"
            return dateFormatter.string(from: timeResult)
        } else if (dayWasOnline, monthWasOnline, yearWasOnline) == ((currentDay - 1), currentMonth, currentYear) {
            dateFormatter.dateFormat = "в HH:mm вчера"
            return dateFormatter.string(from: timeResult)
        } else if yearWasOnline != currentYear {
            return "в прошлом году"
        }  else if currentDateString != wasOnlineString {
            let month = localizeMonth(monthWasOnline)
            dateFormatter.dateFormat = "в HH:mm , d \(month)"
            return dateFormatter.string(from: timeResult)
        } else {
            return nil
        }
    }
    
    func localizeMonth(_ month: Int) -> String {
        switch month {
        case 1: return "Января"
        case 2: return "Февраля"
        case 3: return "Марта"
        case 4: return "Апреля"
        case 5: return "Мая"
        case 6: return "Июня"
        case 7: return "Июля"
        case 8: return "Августа"
        case 9: return "Сентября"
        case 10: return "Октября"
        case 11: return "Ноября"
        case 12: return "Декабря"
        default:
            return "числа"
        }
    }
}

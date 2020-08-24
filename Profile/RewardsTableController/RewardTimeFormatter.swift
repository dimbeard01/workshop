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
        let rewardReceivingDate = Date(timeIntervalSince1970: Double(date))
     
        if let hoursAgo = Calendar.current.dateComponents([.hour], from: rewardReceivingDate, to: Date()).hour {
            return "\(hoursAgo) ч."
        } else {
            return nil
        }
    }
}

//
//  Date+Ext.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 27/01/2024.
//

import Foundation

extension Date {
    func toTimeSince() -> String {
        let calendar = Calendar.current
           let now = Date()
           let components = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: self, to: now)

           if let years = components.year, years >= 1 {
               return "\(years) year(s) and \(components.month ?? 0) month(s) ago"
           } else if let months = components.month, months >= 1 {
               return "\(months) month(s) ago"
           } else if let days = components.day, days >= 1 {
               return "\(days) day(s) ago"
           } else if let hours = components.hour, hours >= 1 {
               return "\(hours) hour(s) ago"
           } else if let minutes = components.minute, minutes >= 1 {
               return "\(minutes) minute(s) ago"
           } else {
               return "now"
           }
    }
}

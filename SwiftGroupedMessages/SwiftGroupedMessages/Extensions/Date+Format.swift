//
//  Date+Format.swift
//  SwiftGroupedMessages
//
//  Created by Tiago Bastos on 06/02/2019.
//

import Foundation

extension Date {
    
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
}

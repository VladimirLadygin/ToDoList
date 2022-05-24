//
//  Date+Extention.swift
//  ToDoList
//
//  Created by Владимир Ладыгин on 16.05.2022.
//

import Foundation

extension Date {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}

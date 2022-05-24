//
//  DateCell.swift
//  ToDoList
//
//  Created by Владимир Ладыгин on 19.05.2022.
//

import UIKit

class DateCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    
    func setDate(_ date: Date) {
        label.text = date.formattedDate
    }
}

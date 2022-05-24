//
//  StringOfExtention.swift
//  ToDoList
//
//  Created by Владимир Ладыгин on 16.05.2022.
//

extension String  {
    var capitalizedWithSpaces: String {
        let withSpaces = reduce("") { result, character in
            character.isUppercase ? "\(result) \(character)" : "\(result) \(character)"
            
        }
        
        return withSpaces.capitalized
    }
}

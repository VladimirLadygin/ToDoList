//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Владимир Ладыгин on 16.05.2022.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    var todos = [ToDo]()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = [
            ToDo(title: "Купить бухлишка", image: UIImage(named: "bottles")),
            ToDo(title: "Купить закуску", image: UIImage(named: "steak")),
            ToDo(title: "Позвать девчонок", image: UIImage(named: "girls")),
        ]
    }
    
    // MARK: UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return todos.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        let todo = todos[indexPath.section]
        configure(cell, with: todo, indexPath: indexPath)
        return cell
    }
    
    // MARK: - Cell Content
    func configure(_ cell: ToDoCell, with todo: ToDo, indexPath: IndexPath) {
        guard let stackView = cell.stackView else { return }
        guard stackView.arrangedSubviews.count == 0 else { return }
        
        stackView.spacing = 0
        let horisontalStack = UIStackView()
        horisontalStack.axis = .horizontal
        
        for index in 0 ..< todo.keys.count {
            let key = todo.capitalizedKeys[index]
            let value = todo.values[index]
            
            if let stringValue = value as? String {
                
                let label = UILabel()
                label.text = stringValue
                if key == "Notes" {
                    stackView.addArrangedSubview(label)
                } else {
                    horisontalStack.addArrangedSubview(label)
                }
            } else if let dateValue = value as? Date {
                
                let label = UILabel()
                label.text = dateValue.formattedDate
                horisontalStack.addArrangedSubview(label)
                
            } else if let boolValue = value as? Bool {
                // Configure button font
                let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .large)
                
                // image in button
                let isChecked = NSTextAttachment()
                let isUnchecked = NSTextAttachment()
                isChecked.image = UIImage(systemName: "checkmark.square.fill", withConfiguration: symbolConfig)
                isUnchecked.image = UIImage(systemName: "square", withConfiguration: symbolConfig)
                
                // Button
                let button = UIButton()
                var imageValue = boolValue ? isChecked.image : isUnchecked.image
                button.setImage(imageValue, for: .normal)
                button.addAction(UIAction(title: "", handler:{ action in
                    
                    guard action.sender is UIButton else { return }
                    
                    self.todos[indexPath.section].isComplete.toggle()
                    imageValue = self.todos[indexPath.section].isComplete ? isChecked.image : isUnchecked.image
                    button.setImage(imageValue, for: .normal)
                    
                } ), for: .touchUpInside)
                // Add button on first place in horisontal stack
                horisontalStack.insertArrangedSubview(button, at: 0)
                
                
            } else if let imageValue = value as? UIImage {
                
                let imageView = UIImageView(image: imageValue)
                imageView.contentMode = .scaleAspectFit
                let heightConstraint = NSLayoutConstraint(
                    item: imageView,
                    attribute: .height,
                    relatedBy: .equal,
                    toItem: nil,
                    attribute: .height,
                    multiplier: 1,
                    constant: stackView.frame.width
                )
                imageView.addConstraint(heightConstraint)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = 10
                stackView.addArrangedSubview(imageView)
            }
            // Add horisontal stack view in vertical stack
            horisontalStack.spacing = 10
            stackView.addArrangedSubview(horisontalStack)
            horisontalStack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            horisontalStack.isLayoutMarginsRelativeArrangement = true
        }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "NewToDoItemSegue" {
            
            let destination = segue.destination as! ToDoItemTableViewController
            destination.todo = ToDo(image: UIImage(named: "placeholder"))
        } else if segue.identifier == "ToDoItemSegue" {
            
            guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
            let destination = segue.destination as! ToDoItemTableViewController
            destination.todo = todos[selectedIndex.section].copy() as! ToDo
        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveSegue" else { return }
        let source = segue.source as! ToDoItemTableViewController
//        guard let selectedIndex = tableView.indexPathForSelectedRow else { return }

//        todos[selectedIndex.section] = source.todo
//
//        if let toDoCell = tableView.cellForRow(at: selectedIndex) as? ToDoCell {
//            if let stackView = toDoCell.stackView {
//                stackView.arrangedSubviews.forEach { subview in
//                    stackView.removeArrangedSubview(subview)
//                    subview.removeFromSuperview()
//                }
//            }
//            tableView.reloadRows(at: [selectedIndex], with: .automatic)
//        } else {
//            todos.append(source.todo)
//            tableView.reloadData()
//        }
        
        if let selectedIndex = tableView.indexPathForSelectedRow {
            todos[selectedIndex.section] = source.todo
            tableView.reloadRows(at: [selectedIndex], with: .automatic)
        } else {
            todos.append(source.todo)
            tableView.reloadData() // Происходит странное, при обновлении таблицы ее содержимое перезагружается с некорректными значениями
        }
    }
    
}

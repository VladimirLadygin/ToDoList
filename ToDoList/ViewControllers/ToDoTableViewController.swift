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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        let todo = todos[indexPath.row]
        configure(cell, with: todo)
        return cell
    }
    
    // MARK: - Cell Content
    func configure(_ cell: UITableViewCell, with todo: ToDo) {
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.isComplete ? "✅" : "❌"
        cell.imageView?.image = todo.image
    }
}

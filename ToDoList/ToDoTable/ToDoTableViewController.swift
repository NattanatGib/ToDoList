//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by gibntn on 30/7/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import UIKit

class ToDoTableViewController: UIViewController {
    
    // MARK: properties
    @IBOutlet weak var toDoTable: UITableView!
    var viewModel: ToDoTableViewModel = .init()
    
    // MARK: methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.router.viewController = self
        viewModel.delegate = self
        viewModel.prepareData()
        toDoTable.register(
            UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoCell")
    }
    
    // กด add แล้วจะ route ให้แสดงหน้า create form
    @IBAction func addButton(_ sender: Any) {
        viewModel.routeToCreateToDoList()
    }
    
    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.router.routeToShowDetail(model: viewModel.getData()[indexPath.row])
    }
}

// แสดงผลในตาราง
extension ToDoTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getData().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        let data = viewModel.getData()[indexPath.row]
        
        cell.delegate = self
        cell.titleLabel.text = "\(data.title)"
        cell.descriptionLabel.text = "\(data.description)"
        cell.checkButton.tag = indexPath.row
        cell.isCheck = data.done
        
        return cell
    }
    
    // swipe to delete and edit ToDoList
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Del") { (action, view, completion) in
            // Perform your action here
            completion(true)
            self.callAlert(index: indexPath.row)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            // Perform your action here
            completion(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = UIColor.red
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = UIColor.gray
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    func callAlert(index: Int) {
        let alertController = UIAlertController(title: "Are you sure",
                                                message: "You want to delete list?",
                                                preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Yes",
                                                style: UIAlertAction.Style.default,
                                                handler: { _ in self.viewModel.deleteToDoList(index: index)}))
        alertController.addAction(UIAlertAction(title: "No",
                                                style: UIAlertAction.Style.default,
                                                handler: nil))
        
        self.present(alertController, animated: true)
    }
}

// ถ้ามีการ checklist จาก ToDoTableViewCell ให้ส่ง index, status ไป update ข้อมูล
extension ToDoTableViewController: TableViewCellDelegate {
    func didSelect(index: Int, isDone: Bool) {
        viewModel.updateToDoStatus(index: index, isDone: isDone)
    }
}

// หลังจาก update ข้อมูลเรียบร้อยแล้ว ให้ reloadData
extension ToDoTableViewController: ToDoTableViewModelDelegate {
    func updateTableView() {
        toDoTable.reloadData()
    }
}

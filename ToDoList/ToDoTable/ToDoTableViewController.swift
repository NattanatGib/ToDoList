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

//
//  CreateToDoListViewController.swift
//  ToDoList
//
//  Created by gibntn on 31/7/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import UIKit

class CreateToDoListViewController: UIViewController {
    
    var viewModel: CreateToDoListViewModel = .init()
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.router.viewController = self
        
        guard let defaultEditData = viewModel.defaultEditData else {
            return
        }
        
        titleText.text = "\(defaultEditData.title)"
        descriptionText.text = "\(defaultEditData.description)"
    }
    
    
    @IBAction func saveCreateToDoList(_ sender: UIButton) {
        let defaultEditData = viewModel.defaultEditData
        let title = titleText.text!
        let description = descriptionText.text!
        if defaultEditData == nil {
            let newToDoList = ToDoData(title: title, description: description, done: false)
            viewModel.createToDoList(newToDoList: newToDoList)
        } else {
            guard let updateIndex = viewModel.updateIndex else {
                return
            }
            let updateToDoList = ToDoData(title: title, description: description, done: defaultEditData!.done)
            viewModel.updateToDoList(index: updateIndex, dataUpdate: updateToDoList)
        }
    }
    
    @IBAction func closeCreateToDoList(_ sender: Any) {
        viewModel.router.closeCreateToDoList()
    }

}

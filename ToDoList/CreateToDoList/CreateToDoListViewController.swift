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
    }
    
    
    @IBAction func saveCreateToDoList(_ sender: UIButton) {
        let title = titleText.text!
        let description = descriptionText.text!
        
        let newToDoList = ToDoData(title: title, description: description, done: false)
        
        viewModel.createToDoList(newToDoList: newToDoList)
        
    }
    
    @IBAction func closeCreateToDoList(_ sender: Any) {
        viewModel.router.closeCreateToDoList()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
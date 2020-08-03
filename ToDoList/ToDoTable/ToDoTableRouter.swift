//
//  ToDoTableRouter.swift
//  ToDoList
//
//  Created by gibntn on 31/7/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import UIKit

class ToDoTableRouter {
    
    weak var viewController: ToDoTableViewController?
    
    func routeToCreateToDoList(model: [ToDoData], index: Int) {
        let storyboard: UIStoryboard = .init(name: "Main", bundle: nil)
        let createVC: CreateToDoListViewController = storyboard.instantiateViewController(identifier: "CreateToDoListStoryboardID")
        createVC.modalPresentationStyle = .overFullScreen
        
        // viewController?.viewModel conform protocol delegate ของ CreateToDoListViewController.viewModel
        createVC.viewModel.delegate = viewController?.viewModel
        
        // ส่ง ข้อมูล ToDoData ทั้งหมด ไปที่ model ในหน้า create
        createVC.viewModel.model = model
        
        // ถ้ากด edit มา ให้เก็บข้อมูลไว้
        if index >= 0 {
            createVC.viewModel.updateIndex = index
            createVC.viewModel.defaultEditData = model[index]
        }
        viewController?.navigationController?.present(createVC, animated: true)
    }
    
    func routeToShowDetail(model: ToDoData) {
        let storyboard: UIStoryboard = .init(name: "Main", bundle: nil)
        let detailVC: ShowDetailViewController = storyboard.instantiateViewController(identifier: "ShowDetailStoryboardID")
        
        // ส่ง ข้อมูล ToDoData ทั้งหมด ไปที่ model ในหน้า showDetail
        detailVC.viewModel.toDoListDetail = model
        
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}

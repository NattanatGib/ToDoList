//
//  ToDoTableViewModel.swift
//  ToDoList
//
//  Created by gibntn on 30/7/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import UIKit

protocol ToDoTableViewModelDelegate: class {
    func updateTableView()
}

class ToDoTableViewModel {
    
    private var model: [ToDoData] = []
    var useCase: ShowDataUseCase = .init()
    weak var delegate: ToDoTableViewModelDelegate?
    var router: ToDoTableRouter = .init()
    
    // ดึงข้อมูลมาแสดงผล
    func prepareData() {
        useCase.getData { [weak self] model in
            self?.model = model
            self?.delegate?.updateTableView()
        }
    }
    
    // เตรียมข้อมูลมาแสดงผล
    func getData() -> [ToDoData] {
        return model
    }
    
    // เมื่อมีการ checklist ให้ไป update data (มีการใช้ callback)
    func updateToDoStatus(index: Int, isDone: Bool) {
        useCase.updateToDoStatus(index: index, isDone: isDone, model: model) { [weak self] model in
            self?.completionHandler(model: model)
        }
    }
    
    private func completionHandler(model: [ToDoData]) {
        // update model
        self.model = model
        // update UI
        self.delegate?.updateTableView()
    }
    
    func routeToCreateToDoList() {
        router.routeToCreateToDoList(model: model) { [weak self] model in
               self?.completionHandler(model: model)
           }
    }
    
    func routeToEditToDoList(index: Int, completionHandler: @escaping ((ToDoData) -> Void)) {
//        router.routeToEditToDoList(model: model, index: index, completionHandler: completionHandler) { [weak self] updateData in
//            self?.model[index] = updateData
//        }
        
        router.routeToEditToDoList(model: model, index: index) { [weak self] updateData in
            self?.model[index] = updateData
            completionHandler(updateData)
        }
    }
    
    func deleteToDoList(index: Int) {
        useCase.deleteToDoList(index: index, model: model) { [weak self] model in
            self?.completionHandler(model: model)
        }
    }
}

extension ToDoTableViewModel: CreateToDoListDelegate {
    func didCreateToDoListSuccess(model: [ToDoData]) {
        self.completionHandler(model: model)
    }
}

//
//  CreateToDoListViewModel.swift
//  ToDoList
//
//  Created by gibntn on 31/7/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import UIKit

protocol CreateToDoListDelegate: class {
    func didCreateToDoListSuccess(model: [ToDoData])
}

class CreateToDoListViewModel {
    
    var useCase: ShowDataUseCase = .init()
    weak var delegate: CreateToDoListDelegate?
    var router: CreateToDoListRouter = . init()
    
    var model: [ToDoData] = []
    var updateIndex: Int?
    var defaultEditData: ToDoData?
    
    func createToDoList(newToDoList: ToDoData) {
        useCase.updateCreateToDoList(newToDoList: newToDoList, model: model) { [weak self] model in
            self?.completionHandler(model: model)
//            self?.delegate?.didCreateToDoListSuccess(model: model)
//            self?.router.closeCreateToDoList()
        }
    }
    
    func updateToDoList(index: Int, dataUpdate: ToDoData) {
        useCase.updateToDoList(index: index, dataUpdate: dataUpdate, model: model) { [weak self] model in
            self?.completionHandler(model: model)
//            self?.delegate?.didCreateToDoListSuccess(model: model)
//            self?.router.closeCreateToDoList()
        }
    }
    
    func completionHandler(model: [ToDoData]) {
        self.delegate?.didCreateToDoListSuccess(model: model)
        self.router.closeCreateToDoList()
    }
    
}

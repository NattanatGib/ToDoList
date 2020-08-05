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
    //    func didUpdateToDoListSuccess(model: ToDoData)
}

class CreateToDoListViewModel {
    
    var useCase: ShowDataUseCase = .init()
    weak var delegate: CreateToDoListDelegate?
    var router: CreateToDoListRouter = . init()
    
    var model: [ToDoData] = []
    var updateIndex: Int?
    var defaultEditData: ToDoData?
    
    var updateSuccessCallback: ((ToDoData) -> Void)! //callback2 ที่ hold ballback1 ไว้
    
//    var updateDataInVM: ((ToDoData) -> Void)!
    
    func createToDoList(newToDoList: ToDoData) {
        useCase.updateCreateToDoList(newToDoList: newToDoList, model: model) { [weak self] model in
            self?.completionHandler(model: model)
        }
    }

    func updateToDoList(index: Int, dataUpdate: ToDoData) {
        useCase.updateToDoList(index: index, dataUpdate: dataUpdate, model: model) { [weak self] model in
            self?.router.closeCreateToDoList()
            self?.updateSuccessCallback(model)
        } // callback3 ที่ hold callback2
    }
    
    func completionHandler(model: [ToDoData]) {
        self.delegate?.didCreateToDoListSuccess(model: model)
        self.router.closeCreateToDoList()
    }
    
}

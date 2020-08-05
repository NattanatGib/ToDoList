//
//  ShowDataUseCase.swift
//  ToDoList
//
//  Created by gibntn on 30/7/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import UIKit

class ShowDataUseCase {
    
    let repository: ToDoTableRepository = .init()
    
    // getDataFromUserDefaults
    func getData(completionHandler: @escaping (([ToDoData]) -> Void)) {
        repository.getDataFromUserDefaults(completionHandler: completionHandler)
    }
    
    // send the data that already updated to store in UserDefault
    func updateToDoStatus(index: Int, isDone: Bool, model: [ToDoData], checkListCallBack: @escaping (([ToDoData]) -> Void)) {
        // update to do status
        var newModel = model
        newModel[index].done = isDone
        
        repository.updateToDoList(model: newModel, completionHandler: checkListCallBack)
    }
    
    // add new ToDoList item to old ToDoList and then send to store in UserDefault
    func updateCreateToDoList(newToDoList: ToDoData, model: [ToDoData], completionHandler: @escaping (([ToDoData]) -> Void)) {
        
        var newModel = model
        newModel.append(newToDoList)
        
        repository.updateToDoList(model: newModel, completionHandler: completionHandler)
    }
    
    // delete item list and then send data to store in UserDefault
    func deleteToDoList(index: Int, model: [ToDoData], completionHandler: @escaping (([ToDoData]) -> Void)) {
        
        var newModel = model
        newModel.remove(at: index)
        
        repository.updateToDoList(model: newModel, completionHandler: completionHandler)
    }
    
//    func updateToDoList(index: Int, dataUpdate: ToDoData, model: [ToDoData], completionHandler: @escaping (([ToDoData]) -> Void)) {
//
//        var newModel = model
//        newModel[index] = dataUpdate
//
//        repository.updateToDoList(model: newModel, completionHandler: completionHandler)
//    }
    func updateToDoList(index: Int, dataUpdate: ToDoData, model: [ToDoData], completionHandler: @escaping ((ToDoData) -> Void)) {
        
        var newModel = model
        newModel[index] = dataUpdate
        
        repository.editToDoList(model: newModel, dataUpdate: dataUpdate, completionHandler: completionHandler
        )
        
        
    }
    
}

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
    
    // ส่งข้อมูลที่ update แล้วไปเก็บใน UserDefault
    func updateToDoStatus(index: Int, isDone: Bool, model: [ToDoData], checkListCallBack: @escaping (([ToDoData]) -> Void)) {
        // update to do status
        var newModel = model
        newModel[index].done = isDone
        
        repository.updateToDoList(model: newModel, completionHandler: checkListCallBack)
    }
    
    // add ข้อมูลใหม่ เข้่าไปในข้อมูลทั้งหมด แล้วส่งไป update ใน userdefault
    func updateCreateToDoList(newToDoList: ToDoData, model: [ToDoData], completionHandler: @escaping (([ToDoData]) -> Void)) {
        
        var newModel = model
        newModel.append(newToDoList)
        
        repository.updateToDoList(model: newModel, completionHandler: completionHandler)
    }
    
    // delete item list แล้วส่งข้อมูลหลังจากที่ลบแล้วไป update ใน userdefault
    func deleteToDoList(index: Int, model: [ToDoData], completionHandler: @escaping (([ToDoData]) -> Void)) {
        
        var newModel = model
        newModel.remove(at: index)
        
        repository.updateToDoList(model: newModel, completionHandler: completionHandler)
    }

}

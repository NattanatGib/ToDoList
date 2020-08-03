//
//  ToDoTableRepository.swift
//  ToDoList
//
//  Created by gibntn on 30/7/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import Foundation

struct ToDoData: Codable {
    var title: String
    var description: String
    var done: Bool
}

class ToDoTableRepository {
    
    private let key = "ToDoList"
    
//    func getMockData(completionHandler: @escaping (([ToDoData]) -> Void)) {
//        let toDoList = [ToDoData(title: "Send email",
//                                 description: "Don't forget to send email to boss",
//                                 done: false),
//                        ToDoData(title: "Join meeting",
//                                 description: "Standup meeting today on 9.00 am",
//                                 done: true),
//                        ToDoData(title: "Debug",
//                                 description: "Debug login feature",
//                                 done: false),
//                        ToDoData(title: "Submit myTE",
//                                 description: "Submit 1st myTE",
//                                 done: false)]
//        completionHandler(toDoList)
//    }
    
    // ดึงข้อมูงจาก userdefaults มาแสดงผล
    func getDataFromUserDefaults(completionHandler: @escaping (([ToDoData]) -> Void)) {
        let jsonObject = UserDefaults.standard.object(forKey: key)
        if let data = jsonObject as? Data,
            let model = try? JSONDecoder().decode([ToDoData].self, from: data) {
            completionHandler(model)
        }
    }
    
    // receive all ToDoList data and update userdefaults
    func updateToDoList(model: [ToDoData], completionHandler: @escaping (([ToDoData]) -> Void)) {
        // update userdefault with model
        let encodeData = try? JSONEncoder().encode(model)
        UserDefaults.standard.set( encodeData , forKey: key)
        completionHandler(model)
    }

}

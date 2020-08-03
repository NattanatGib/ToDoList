//
//  CreateToDoListRouter.swift
//  ToDoList
//
//  Created by gibntn on 31/7/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import UIKit

class CreateToDoListRouter  {
 
    var viewController: CreateToDoListViewController?
    
    func closeCreateToDoList() {
        viewController?.dismiss(animated: true)
    }
}

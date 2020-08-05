//
//  ShowDetailViewController.swift
//  ToDoList
//
//  Created by gibntn on 1/8/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController {

    var viewModel: ShowDetailViewModel = .init()
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataOnScene()
    }
    
    func setDataOnScene() {
        guard let data = viewModel.toDoListDetail else {
            return
        }
        var image: UIImage?
        if data.done {
            image = UIImage(systemName: "checkmark.circle.fill")
        } else {
          image = UIImage(systemName: "checkmark.circle")
        }
        titleText.text = data.title
        descriptionText.text = data.description
        checkButton.setBackgroundImage(image, for: .normal)
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

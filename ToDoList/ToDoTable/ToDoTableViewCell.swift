//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by gibntn on 30/7/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate: class {
    func didSelect(index: Int, isDone: Bool)
}

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    weak var delegate: TableViewCellDelegate?

    var isCheck: Bool = true {
        didSet {
            var image: UIImage?
            if isCheck {
                image = UIImage(systemName: "checkmark.circle.fill")
            } else {
              image = UIImage(systemName: "checkmark.circle")
            }
            checkButton.setBackgroundImage(image, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }

    @IBAction func checkAction(_ sender: UIButton) {
        isCheck = !isCheck
        delegate?.didSelect(index: sender.tag, isDone: isCheck)
    }
}

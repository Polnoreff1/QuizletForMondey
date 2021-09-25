//
//  TaskTableViewCell.swift
//  QuizletForMondey
//
//  Created by Андрей  on 21.09.2021.
//

import UIKit

protocol CustomTVCDelegate {
    func switchIsPushed(cell: UITableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet var title: UILabel!
    @IBOutlet var cellSwitch: UISwitch!
    @IBOutlet var imageCell: UIImageView!
    
    //MARK: - Property
    var delegate: CustomTVCDelegate?
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - IBAction
    @IBAction func actionForCellSwitch(_ sender: Any) {
        delegate?.switchIsPushed(cell: self)
        switch cellSwitch.isOn {
        case true:
            imageCell.image = UIImage(imageLiteralResourceName: "trueDone")
        case false:
            imageCell.image = UIImage(imageLiteralResourceName: "done")
        }
    }
}


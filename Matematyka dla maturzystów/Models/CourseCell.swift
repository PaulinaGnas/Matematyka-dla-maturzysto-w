//
//  CourseCell.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 15/12/2021.
//

import UIKit

class CourseCell: UITableViewCell {

    @IBOutlet weak var courseView: UIView!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var courseImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        courseView.layer.cornerRadius = courseView.frame.size.height / 7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

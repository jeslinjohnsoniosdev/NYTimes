//
//  NewsTVC.swift
//  NYTimes
//
//  Created by Chanchal Raj on 02/03/2021.
//  Copyright © 2021 Jeslin Johnson. All rights reserved.
//

import UIKit

class NewsTVC: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateCell(title: String?, abstract: String?) {
        titleLabel.text = title ?? ""
        abstractLabel.text = abstract ?? ""
        //media
    }
}

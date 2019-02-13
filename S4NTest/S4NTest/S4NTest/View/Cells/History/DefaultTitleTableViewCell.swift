//
//  DefaultTitleTableViewCell.swift
//  S4NTest
//
//  Created by Gonzalinho on 2/12/19.
//  Copyright © 2019 Gonzalinho. All rights reserved.
//

import UIKit

class DefaultTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInterface()
    }
    
    private func setupInterface() {
        descriptionLabel.numberOfLines = 2
    }
    
    func setupCell(item: String) {
        descriptionLabel.text = item
    }
    
}

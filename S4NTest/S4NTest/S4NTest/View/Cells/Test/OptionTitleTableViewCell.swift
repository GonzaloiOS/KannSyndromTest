//
//  OptionTitleTableViewCell.swift
//  S4NTest
//
//  Created by Gonzalinho on 2/12/19.
//  Copyright © 2019 Gonzalinho. All rights reserved.
//

import UIKit

protocol OptionTitleTableViewCellDelegate {
    func answerUpdated(cell: OptionTitleTableViewCell)
}

class OptionTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var answerSwitch: UISwitch!
    
    var delegate: OptionTitleTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInterface()
    }
    
    private func setupInterface() {
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        selectionStyle = .none
        descriptionText.numberOfLines = 2
        descriptionText.textAlignment = .center
    }
    
    func setupCell(item: KannQuestion) {
        answerSwitch.setOn(item.status, animated: false)
        descriptionText.text = item.type.path
    }
    
    
    @IBAction func valueChanged(_ sender: UISwitch) {
        delegate?.answerUpdated(cell: self)
    }
    
}

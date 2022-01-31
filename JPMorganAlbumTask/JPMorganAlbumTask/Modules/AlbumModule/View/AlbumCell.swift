//
//  AlbumCell.swift
//  JPMprgan Albums Task
//
//  Created by Chinny Ponnoose on 30/01/22.
//

import UIKit

class AlbumCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!

    func configure(_ model: AlbumModel) {
        titleLabel.text = model.title
        userIdLabel.text = String(model.userId)
    }

}

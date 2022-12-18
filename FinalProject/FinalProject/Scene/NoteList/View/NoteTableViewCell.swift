//
//  NoteTableViewCell.swift
//  FinalProject
//
//  Created by Tarik Efe on 15.12.2022.
//

import UIKit

final class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    func configureCell(model: Note) {
        nameLabel.text = model.game
        noteLabel.text = model.note
    }
    
}

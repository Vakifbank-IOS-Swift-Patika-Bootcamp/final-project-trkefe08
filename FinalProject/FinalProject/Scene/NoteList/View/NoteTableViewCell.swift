//
//  NoteTableViewCell.swift
//  FinalProject
//
//  Created by Tarik Efe on 15.12.2022.
//

import UIKit

final class NoteTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var noteLabel: UILabel!
    //MARK: - Methods
    func configureCell(model: Note) {
        nameLabel.text = model.game
        noteLabel.text = model.note
    }
    
}

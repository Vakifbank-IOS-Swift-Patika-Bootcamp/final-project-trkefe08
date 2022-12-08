//
//  GameListTableViewCell.swift
//  FinalProject
//
//  Created by Tarik Efe on 8.12.2022.
//

import UIKit
import Kingfisher

class GameListTableViewCell: UITableViewCell {
//MARK: Outlets
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
//MARK: Methods
    func configureCell(game: GameListResultModel) {
        nameLabel.text = game.name
        guard let url = URL(string: game.backgroundImage ?? "not found") else { return }
        gameImageView.kf.setImage(with: url)
    }
//MARK: Lifecycle
    override func prepareForReuse() {
        gameImageView.image = nil
    }
}

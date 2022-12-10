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
    @IBOutlet private weak var gameImageView: UIImageView! {
        didSet {
            gameImageView.layer.cornerRadius = gameImageView.frame.height / 10
            gameImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var topRatingLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    
    //MARK: Methods
    func configureCell(game: GameListResultModel) {
        nameLabel.text = game.name
        topRatingLabel.text = "\(game.ratingTop ?? 0)"
        ratingLabel.text = "\(game.rating ?? 0) / "
        releaseDateLabel.text = game.released
        guard let url = URL(string: game.backgroundImage ?? "not found") else { return }
        gameImageView.kf.setImage(with: url)
    }
//MARK: Lifecycle
    override func prepareForReuse() {
        gameImageView.image = nil
    }
}

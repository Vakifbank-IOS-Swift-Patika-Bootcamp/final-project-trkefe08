//
//  GameListTableViewCell.swift
//  FinalProject
//
//  Created by Tarik Efe on 8.12.2022.
//

import UIKit
import Kingfisher

final class GameListTableViewCell: UITableViewCell {
//MARK: IBOutlets
    @IBOutlet private weak var gameImageView: UIImageView! {
        didSet {
            gameImageView.layer.cornerRadius = 10.0
        }
    }
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var topRatingLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var releaseLocalize: UILabel!
    @IBOutlet  private weak var ratingTopRatingLabel: UILabel!
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutSubviews()
        self.layer.cornerRadius = 10.0
    }
    
    override func prepareForReuse() {
        gameImageView.image = nil
    }
    //MARK: - Methods
    func configureCell(game: GameListResultModel) {
        nameLabel.text = game.name
        topRatingLabel.text = "\(game.ratingTop ?? 0)"
        ratingLabel.text = "\(game.rating ?? 0) / "
        releaseDateLabel.text = game.released
        guard let url = URL(string: game.backgroundImage ?? "not found") else { return }
        gameImageView.kf.setImage(with: url)
        releaseLocalize.text = "Release Date".localized()
        ratingTopRatingLabel.text = "Rating/Top Rating".localized()
    }
    
    func configureFavoriteGameCell(favorites: FinalProject) {
        guard let url = URL(string: favorites.image ?? "not found") else { return }
        gameImageView.kf.setImage(with: url)
        nameLabel.text = favorites.name
        releaseDateLabel.text = favorites.releaseDate
        ratingLabel.text = "\(favorites.rating)"
        topRatingLabel.text = "\(favorites.topRating)"
    }
}

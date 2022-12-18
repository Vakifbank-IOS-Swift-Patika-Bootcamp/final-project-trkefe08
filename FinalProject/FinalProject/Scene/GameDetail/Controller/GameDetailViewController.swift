//
//  GameDetailViewController.swift
//  FinalProject
//
//  Created by Tarik Efe on 11.12.2022.
//

import UIKit

final class GameDetailViewController: UIViewController {
    //MARK: - IBOutlets
    
    @IBOutlet private weak var releaseLocalize: UILabel!
    @IBOutlet private weak var ratingLocalize: UILabel!
    @IBOutlet private weak var metaLocalize: UILabel!
    @IBOutlet private weak var descriptLocalize: UILabel!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var topRatingLabel: UILabel!
    @IBOutlet private weak var metaScoreLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var addFavoriteButton: UIBarButtonItem!
    
    //MARK: - Variables
    var gameId: Int?
    private var viewModel: GameDetailViewModelProtocol = GameDetailViewModel()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = gameId else { return }
        viewModel.delegate = self
        viewModel.fetchGameDetail(id: id)
        title = "Details".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.showFavorite(id: gameId ?? 0)
    }
    
    
    //MARK: - IBActions
    @IBAction func addFavoriteButton(_ sender: UIBarButtonItem) {
        viewModel.addFavorite(id: gameId ?? 0)
    }
}


//MARK: - Extensions
extension GameDetailViewController: GameDetailViewModelDelegate {
    func gameLoaded() {
        nameLabel.text = viewModel.getGameTitle()
        releaseDateLabel.text = viewModel.getGameRelease()
        ratingLabel.text = "\(viewModel.getRating()) / "
        topRatingLabel.text = "\(viewModel.getTopRating())"
        metaScoreLabel.text = "\(viewModel.getMetaScore())"
        descriptionLabel.text = viewModel.getGameDescription()
        guard let url = viewModel.getGameImageURL() else { return }
        gameImageView.kf.setImage(with: url)
        releaseLocalize.text = "Release Date".localized()
        ratingLocalize.text = "Rating".localized()
        metaLocalize.text = "Meta Score".localized()
        descriptLocalize.text = "Description".localized()
    }
    
    func didAddFavorite(status: Bool) {
        if status == false {
            self.addFavoriteButton.image = UIImage(systemName: "heart.fill")
        } else {
            self.addFavoriteButton.image = UIImage(systemName: "heart")

        }
    }
}

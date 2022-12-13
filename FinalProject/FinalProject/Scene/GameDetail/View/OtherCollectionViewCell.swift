//
//  OtherCollectionViewCell.swift
//  FinalProject
//
//  Created by Tarik Efe on 12.12.2022.
//

import UIKit
import Kingfisher

final class OtherCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var otherImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(model: ResultModel) {
        guard let url = URL(string: model.backgroundImage ?? "not found") else { return }
        otherImageView.kf.setImage(with: url)
        nameLabel.text = model.name
    }

}

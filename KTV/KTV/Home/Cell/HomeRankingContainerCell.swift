//
//  HomeRankingContainerCell.swift
//  KTV
//
//  Created by Bokyung on 7/28/24.
//

import UIKit

protocol HomeRankingContainerCellDelegate: AnyObject {
    func homeRankingContainerCell(_ cell: HomeRankingContainerCell, didSelectItemAt index: Int)
}

class HomeRankingContainerCell: UITableViewCell {

    static let identifier: String = "HomeRankingContainerCell"
    static let height: CGFloat = 349
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: HomeRankingContainerCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.collectionView.register(
            UINib(nibName: HomeRankingItemCell.identifier,
                  bundle: nil),
            forCellWithReuseIdentifier: HomeRankingItemCell.identifier
        )
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension HomeRankingContainerCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRankingItemCell.identifier, for: indexPath)

        if let cell = cell as? HomeRankingItemCell {
            cell.setRank(indexPath.item + 1)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.delegate?.homeRankingContainerCell(self, didSelectItemAt: indexPath.item)
    }
}

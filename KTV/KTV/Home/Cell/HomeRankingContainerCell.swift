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

/**
 UITableViewCell -> UICollectionViewCell
 */
class HomeRankingContainerCell: UICollectionViewCell {

    static let identifier: String = "HomeRankingContainerCell"
    static let height: CGFloat = 349
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: HomeRankingContainerCellDelegate?
    private var ranking: [Home.Ranking]?

    // nib 파일이 로드된 후 초기화 작업을 수행
    override func awakeFromNib() {
        super.awakeFromNib()

        // collectionView에 cell 등록
        self.collectionView.register(
            UINib(nibName: HomeRankingItemCell.identifier,
                  bundle: nil),
            forCellWithReuseIdentifier: HomeRankingItemCell.identifier
        )
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    // 외부에서 데이터를 설정하고 컬렉션 뷰를 다시 로드
    func setData(_ data: [Home.Ranking]) {
        self.ranking = data
        self.collectionView.reloadData()
    }
}

extension HomeRankingContainerCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.ranking?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeRankingItemCell.identifier,
            for: indexPath
        )

        if let cell = cell as? HomeRankingItemCell,
            let data = self.ranking?[indexPath.item] {
            cell.setData(data, rank: indexPath.item + 1)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.delegate?.homeRankingContainerCell(self, didSelectItemAt: indexPath.item)
    }
}

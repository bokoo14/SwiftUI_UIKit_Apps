//
//  HomeRankingItemCell.swift
//  KTV
//
//  Created by Bokyung on 7/28/24.
//

import UIKit

class HomeRankingItemCell: UICollectionViewCell {

    static let identifier: String = "HomeRankingItemCell"

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!

    private var imageTask: Task<Void, Never>?

    /**
     인터페이스 빌더에서 설정된 뷰의 속성들을 초기화하거나 추가적인 설정을 할 때 유용
     뷰가 Nib 파일에서 로드될 때 호출
     보통 뷰가 생성된 직후에 한 번만 호출
     UIViewController의 경우, viewDidLoad가 호출되기 전에 호출됨
     Nib 파일에서 뷰가 로드된 후에 호출되므로, Nib 파일에서 설정된 모든 아웃렛과 속성이 이미 연결된 상태
     */
    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.cornerRadius = 10
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.imageTask?.cancel()
        self.imageTask = nil

        self.numberLabel.text = nil
        self.thumbnailImageView.image = nil
    }

    func setRank(_ rank: Int) {
        self.numberLabel.text = "\(rank)"
    }

    func setData(_ data: Home.Ranking, rank: Int) {
        self.numberLabel.text = "\(rank)"

        self.imageTask = self.thumbnailImageView.loadImage(url: data.imageUrl)
    }
}

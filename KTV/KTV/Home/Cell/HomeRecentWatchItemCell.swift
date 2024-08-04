//
//  HomeRecentWatchItemCell.swift
//  KTV
//
//  Created by Bokyung on 7/28/24.
//

import UIKit

class HomeRecentWatchItemCell: UICollectionViewCell {

    static let identifier: String = "HomeRecentWatchItemCell"

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.thumbnailImageView.layer.cornerRadius = 42
        self.thumbnailImageView.layer.borderWidth = 2
        self.thumbnailImageView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
    }

    /**
     - super.prepareForReuse() 메서드
     UICollectionViewCell 또는 UITableViewCell이 재사용되기 전에 호출되는 메서드
     셀이 재사용될 때 기존 데이터와 상태를 정리하는 데 사용 (셀의 상태를 초기화하는 데 사용)
     이미 설정된 데이터를 지우거나, 애니메이션을 중지하거나, 기본값으로 되돌리는 등의 작업을 수행할 수 있음

     - super.prepareForReuse()
     기본 클래스에서 제공하는 초기화 작업이 수행된다.
     이를 통해 셀이 재사용될 때 예상치 못한 상태를 방지할 수 있습니다.
     */
    override func prepareForReuse() {
        super.prepareForReuse()

        // TODO: image task
        self.thumbnailImageView.image = nil
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
        self.dateLabel.text = nil
    }

    func setData(_ data: Home.Recent) {
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.channel
        // TODO: image task
    }
}

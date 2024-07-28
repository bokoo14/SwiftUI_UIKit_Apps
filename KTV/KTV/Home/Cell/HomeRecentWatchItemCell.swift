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
}

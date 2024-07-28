//
//  HomeVideoCell.swift
//  KTV
//
//  Created by Bokyung on 7/27/24.
//

import UIKit

class HomeVideoCell: UITableViewCell {
    static let identifier: String = "HomeVideoCell"
    static let height: CGFloat = 320

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var hotImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var channelSubtitleLabel: UILabel!

    // xib에서 만든 UI에 대해서는 awakeFromNib에서 처리해주어야 한다.
    override func awakeFromNib() {
        super.awakeFromNib()

        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
        self.containerView.layer.borderWidth = 1

        // component에 따라 cornerRadius, borderColor, borderWidth ,, 적용되지 않을수도 있다.
        // -> layer에 대해 configuration을 적용했어도 잘 동작히지 않는다면, clipsToBounds = true
        // self.containerView.layer.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

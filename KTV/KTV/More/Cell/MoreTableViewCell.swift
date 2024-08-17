//
//  MoreTableViewCell.swift
//  KTV
//
//  Created by Bokyung on 8/17/24.
//

import UIKit

class MoreTableViewCell: UITableViewCell {
    static let identifier: String = "MoreTableViewCell"
    static let rowHeight: CGFloat = 48

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.descriptionLabel.text = nil
        self.titleLabel.text = nil
    }

    func setItem(_ item: MoreItem, separatorHidden: Bool) {
        self.titleLabel.text = item.title
        self.descriptionLabel.text = item.rightText
        self.separatorView.isHidden = separatorHidden
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

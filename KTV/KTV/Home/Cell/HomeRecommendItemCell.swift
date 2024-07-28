//
//  HomeRecommendItemCell.swift
//  KTV
//
//  Created by Bokyung on 7/28/24.
//

import UIKit

class HomeRecommendItemCell: UITableViewCell {
    /**
     static
     클래스 레벨에서 접근 가능
     static 키워드는 클래스의 인스턴스를 생성하지 않고도 클래스 레벨에서 바로 접근할 수 있게 한다.
     즉, HomeRecommendItemCell 클래스의 인스턴스를 만들지 않고도 height와 identifier에 접근할 수 있다.

     메모리 절약
     static 키워드를 사용하면 클래스당 하나의 인스턴스만 생성되므로, 메모리를 절약할 수 있다.
     인스턴스 변수로 정의할 경우 각 셀 인스턴스마다 해당 변수가 존재하게 되지만, static으로 정의하면 클래스당 하나만 존재한다.
     */
    static let height: CGFloat = 71
    static let identifier: String = "HomeRecommendItemCell"

    @IBOutlet weak var thumbnailContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var playTimeBGView: UIView!
    @IBOutlet weak var playTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.thumbnailContainerView.layer.cornerRadius = 5
        self.rankLabel.layer.cornerRadius = 5
        self.rankLabel.clipsToBounds = true
        self.playTimeBGView.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

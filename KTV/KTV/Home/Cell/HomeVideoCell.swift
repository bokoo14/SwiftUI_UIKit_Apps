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

    /**
     xib에서 만든 UI에 대해서는 awakeFromNib에서 처리해주어야 한다.
     XIB로 만든 UI가 이 class에 정상적으로 연동을 마쳤을떄 불린다.
     */
    override func awakeFromNib() {
        super.awakeFromNib()

        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
        self.containerView.layer.borderWidth = 1

        // component에 따라 cornerRadius, borderColor, borderWidth ,, 적용되지 않을수도 있다.
        // -> layer에 대해 configuration을 적용했어도 잘 동작히지 않는다면, clipsToBounds = true
        // self.containerView.layer.clipsToBounds = true
    }

    /**
     셀이 재사용될 수 있는데, 셀이 재사용되기 전에 초기화해주는 메서드
     초기화가 제대로 되어 있지 않다면, 특정 조건에서만 보이는 UI가 있다면 다음에 setData를 할 때, 그 Data가 없다면 그 Data가 계속 노출되고 있음
     적절히 초기화를 해줘야 의도치 않는 UI가 보이지 않을 수 있음
     */
    override func prepareForReuse() {
        super.prepareForReuse()

        // TODO: thumbnail Task

        self.thumbnailImageView.image = nil
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
        self.channelTitleLabel.text = nil
        self.channelImageView.image = nil
        self.channelSubtitleLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(_ data: Home.Video) {
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.subtitle
        self.channelTitleLabel.text = data.channel
        self.channelSubtitleLabel.text = data.channelDescription
        self.hotImageView.isHidden = !data.isHot
        // TODO: tumbnail Task
    }
}


/**
 일반적인 뷰
 두 init의 진입점이 다르다

 - 코드로 뷰를 생성한다면 - init frame으로 뷰를 생성
 - Interface Builder를 사용할 때 (xib 또는 storyboard) - nib에 대한 로드가 끝나지 않아서 ui 데이터가 연동이 되어 있지 않음 -> awakeFromNib에서 init을 해야 함
 - Interface Builder를 사용할 때 (xib 또는 storyboard) - init coder 메서드가 호출된 후 awakeFromNib 메서드가 호출된다.
 - awakeFromNib메서드: 모든 아울렛과 설정이 완료된 상태에서 추가 초기화 작업을 수행할 수 있도록 한다 
 required init?(coder: NSCoder) {
     super.init(coder: coder)
 }
 - cell은 awakeFromNib에서 처리
 - VC는 viewDidLoad에서 처리
 */

class SampleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

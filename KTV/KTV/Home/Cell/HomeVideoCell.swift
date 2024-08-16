//
//  HomeVideoCell.swift
//  KTV
//
//  Created by Bokyung on 7/27/24.
//

import UIKit

/**
 UITableViewCell -> UICollectionViewCell
 */
class HomeVideoCell: UICollectionViewCell {
    static let identifier: String = "HomeVideoCell"
    static let height: CGFloat = 300

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var hotImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var channelSubtitleLabel: UILabel!

    /**
     thumbnailTask, channelThumbnailTask: 썸네일 이미지, 채널 썸네일 이미지를 비동기적으로 로드하거나 처리하는 작업
     optional로 처리하여 초기에는 작업이 없을 수 있으며, 필요할 때 비동기 작업을 할당할 수 있음. 작업이 완료되거나, 필요 없을 때는 nil로 설정하여 작업을 취소하거나 메모리 해제 가능

     Task<Void, Never>?: 비동기 작업을 표현하는 타입
     Void: 작업이 완료되었을 때 반환할 값의 타입 (반환 값이 없음을 의미)
     Never: 이 작업에서 오류가 발생하지 않음을 의미 (오류를 던지지 않으므로 try-catch로 처리할 필요 없음)

     Task를 사용하는 이유
     - 비동기 작업 관리: 비동기 작업을 실행하고 관리할 수 있는 구조 제공. 메인 스레드를 차단하지 않고, 백그라운드에서 실행될 수 있음
     - 작업 취소 가능성: 객체의 취소 기능 제공하여 화면을 떠나거나 작업이 필요하지 않다면 Task를 취소하여 불필요한 리소스 소비 방지 가능
        thumbnailTask?.cancel()과 같은 방법으로 작업을 취소할 수 있음
     - 옵셔널 타입: Task변수를 옵셔널로 선언함으로써 필요할 때만 작업을 생성하고, 필요 없을 때는 'nil'로 설정하여 메모리 관리
        작업이 존재하는지 여부를 쉽게 확인하고, 작업이 이미 실행 중인지 확인할 수 있음'
     */
    private var thumbnailTask: Task<Void, Never>?
    private var channelThumbnailTask: Task<Void, Never>?

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

        self.channelImageView.layer.cornerRadius = 10
    }

    /**
     셀이 재사용될 수 있는데, 셀이 재사용되기 전에 초기화해주는 메서드
     초기화가 제대로 되어 있지 않다면, 특정 조건에서만 보이는 UI가 있다면 다음에 setData를 할 때, 그 Data가 없다면 그 Data가 계속 노출되고 있음
     적절히 초기화를 해줘야 의도치 않는 UI가 보이지 않을 수 있음
     */
    override func prepareForReuse() {
        super.prepareForReuse()

        self.thumbnailTask?.cancel()
        self.thumbnailTask = nil
        self.channelThumbnailTask?.cancel()
        self.channelThumbnailTask = nil

        self.thumbnailImageView.image = nil
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
        self.channelTitleLabel.text = nil
        self.channelImageView.image = nil
        self.channelSubtitleLabel.text = nil
    }

    func setData(_ data: Home.Video) {
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.subtitle
        self.channelTitleLabel.text = data.channel
        self.channelSubtitleLabel.text = data.channelDescription
        self.hotImageView.isHidden = !data.isHot

        self.thumbnailTask = self.thumbnailImageView.loadImage(url: data.imageUrl)
        self.channelThumbnailTask = self.channelImageView.loadImage(url: data.channelThumbnailURL)
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

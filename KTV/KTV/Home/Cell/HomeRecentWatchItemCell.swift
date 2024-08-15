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

    private var imageTask: Task<Void, Never>?
    /**
     static: 클래스의 모든 인스턴스에 공통적으로 사용됨을 의미
        이 클래스의 여러 인스턴스가 있더라도 dateFormatter는 하나만 존재하며, 모든 인스턴스가 동일한 DateFormatter 객체를 공유함
     private: 클래스 또는 구조체 내부에서만 접근 가능하도록 함으로써 외부에서 이 속성에 접근할 수 없게 하여 캡슐화 유지

     왜 static let으로 구현?
     - 공유 인스턴스 사용: DateFormatter는 생성 비용이 높은 객체이므로, 여러 번 생성하면 성능에 영향을 줄 수 있음. 클래스 전체에서 하나의 인스턴스를 공유하여 불필요한 인스턴스 생성을 방지함
     - 불변 객체로 사용: DateFormatter는 생성 후 변경될 수 없음
     - 빠른 접근: static으로 선언된 속성은 인스턴스화 없이도 클래스 자체에서 바로 접근할 수 있음. 따라서 여러 곳에서 동일한 날짜 변환을 필요로 할 경우, dataFormatter를 직접 사용할 수 있어서 성능이 최적화됨
     */
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYMMDD"

        return formatter
    }()

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

        self.imageTask?.cancel()
        self.imageTask = nil

        self.thumbnailImageView.image = nil
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
        self.dateLabel.text = nil
    }

    func setData(_ data: Home.Recent) {
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.channel

        /**
         self vs Self
         - self: 현재 객체의 인스턴스를 참조. 메서드나 속성이 속한 객체의 인스턴스를 가리킴
            인스턴스 메서드나 속성에서 주로 사용. 현재 객체의 속성이나 메서드에 접근할 때 사용
         - Self: 타입(클래스, 구조체, 열거형) 자체를 참조. 클래스, 구조체 또는 열거형의 정의 내에서 해당 타입 자체를 나타낼 때 사용
            일반적으로 클래스 메서드나 타입 메서드(클래스 메서드 혹은 구조체의 static 메서드) 내에서 사용되거나, 타입 자체를 반환하거나 생성할 때 사용
         */
        self.dateLabel.text = Self.dateFormatter.string(
            from: .init(timeIntervalSince1970: data.timeStamp)
        )
        self.imageTask = self.thumbnailImageView.loadImage(url: data.imageUrl)
    }
}

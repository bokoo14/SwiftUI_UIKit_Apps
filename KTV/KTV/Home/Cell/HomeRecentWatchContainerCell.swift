//
//  HomeRecentWatchContainerCell.swift
//  KTV
//
//  Created by Bokyung on 7/28/24.
//

import UIKit

// 셀에서 항목을 선택했을 때 델리게이트에게 알리는 메서드를 정의
protocol HomeRecentWatchContainerCellDelegate: AnyObject {
    func homeRecentWatchContainerCell(_ cell: HomeRecentWatchContainerCell, 
                                      didSelectItemAt index: Int)
}

// HomeRecentWatchContainerCell 클래스는 UITableViewCell을 상속
class HomeRecentWatchContainerCell: UITableViewCell {

    static let identifier: String = "HomeRecentWatchContainerCell"
    static let height: CGFloat = 209

    @IBOutlet weak var collectionView: UICollectionView!
    // delegate는 항목 선택을 처리하기 위한 델리게이트
    weak var delegate: HomeRecentWatchContainerCellDelegate?
    private var recents: [Home.Recent]?

    // awakeFromNib는 nib 파일이 로드된 후 호출
    override func awakeFromNib() {
        super.awakeFromNib()

        self.collectionView.layer.cornerRadius = 10
        self.collectionView.layer.borderWidth = 1
        self.collectionView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor

        // collectionView에 셀을 등록
        self.collectionView.register(
            UINib(nibName: HomeRecentWatchItemCell.identifier, bundle: .main),
            forCellWithReuseIdentifier: HomeRecentWatchItemCell.identifier
        )
        // 데이터 소스 및 델리게이트 설정
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // setData 메서드는 외부에서 데이터를 설정하고 컬렉션 뷰를 다시 로드
    // 커스텀 셀 클래스에서 자주 사용하는 패턴
    func setData(_ data: [Home.Recent]) {
        self.recents = data
        self.collectionView.reloadData()
    }
}

/**
 - UICollectionViewDataSource 프로토콜의 메서드를 구현하여 컬렉션 뷰의 항목 수와 셀을 설정
 collectionView(_:numberOfItemsInSection:): 섹션의 항목 수를 반환
 collectionView(_:cellForItemAt:): 인덱스 경로에 해당하는 셀을 반환하고 데이터를 설정

 - UICollectionViewDelegate 프로토콜의 메서드를 구현하여 항목이 선택되었을 때 델리게이트에게 알림
 collectionView(_:didSelectItemAt:): 항목이 선택되었을 때 호출됩니다.

 */
extension HomeRecentWatchContainerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.recents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeRecentWatchItemCell.identifier,
            for: indexPath
        )

        if let cell = cell as? HomeRecentWatchItemCell,
           let data = self.recents?[indexPath.item] {
            cell.setData(data)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.homeRecentWatchContainerCell(self, didSelectItemAt: indexPath.item)
    }
}

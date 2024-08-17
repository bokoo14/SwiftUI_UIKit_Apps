//
//  VideoViewController.swift
//  KTV
//
//  Created by Bokyung on 8/16/24.
//

import UIKit

class VideoViewController: UIViewController {

    // MARK: 제어 패널
    @IBOutlet weak var playButton: UIButton!

    // MARK: - scroll
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var channelThumbnailImageView: UIImageView!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var recommendTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!


    /**
     NSKeyValueObservation
     NSKeyValueObservation 타입의 옵셔버를 저장
     특정 객체의 프로퍼티 값을 관찰하고, 값이 변경될 때 실행될 코드(클로저)를 정의할 수 있다.
     recommendTableView의 contentSize 속성을 관찰하여 테이블 뷰의 내용이 변경될 때 테이블 뷰의 높이를 자동으로 조정하는 데 사용됨
     */
    private var contentSizeObservation: NSKeyValueObservation?

    override init(nibName nibNameorNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameorNil, bundle: nibBundleOrNil)

        self.modalPresentationStyle = .fullScreen
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.modalPresentationStyle = .fullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.channelThumbnailImageView.layer.cornerRadius = 14
        self.setupRecommendTableView()
    }

    @IBAction func commentDidTap(_ sender: Any) {

    }
}

extension VideoViewController {
    @IBAction func toggleControlPannel(_ sender: Any) {
    }

    @IBAction func closeDidTap(_ sender: Any) {
    }

    @IBAction func moreDidTap(_ sender: Any) {
    }

    @IBAction func fastForwardDidTap(_ sender: Any) {
    }

    @IBAction func playDidTap(_ sender: Any) {
    }

    @IBAction func rewindDidTap(_ sender: Any) {
    }

    @IBAction func expandDidTap(_ sender: Any) {
    }
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupRecommendTableView() {
        // 테이블 뷰가 표시할 데이터와 동작을 이 뷰 컨트롤러가 관리
        self.recommendTableView.delegate = self
        self.recommendTableView.dataSource = self

        self.recommendTableView.rowHeight = VideoListItemCell.height
        self.recommendTableView.register(
            UINib(nibName: VideoListItemCell.identifier, bundle: nil),
            forCellReuseIdentifier: VideoListItemCell.identifier)

        /**
         recommendTableView의 contentSize 속성을 관찰
         contentSize는 테이블 뷰의 모든 셀과 섹션의 내용에 따른 전체 크기를 나타냄

         옵저버 생성: observe 메소드는 KVO (Key-Value Observing)를 사용하여 contentSize의 변화를 감지하고, 지정된 클로저를 호출
         클로저 내 동작: contentSize가 변경되면, 클로저 내에서 테이블 뷰의 높이 제약조건(tableViewHeightConstraint.constant)을 테이블 뷰의 contentSize.height로 업데이트
         이를 통해 테이블 뷰의 높이가 내용물의 높이에 맞게 동적으로 조정된다

         UITableView의 내용 크기를 실시간으로 관찰하여, 테이블 뷰의 높이를 그에 맞춰 자동으로 조정한다. 이를 통해 사용자는 테이블 뷰 안의 내용이 변경되더라도 뷰 레이아웃이 적절히 유지되도록 할 수 있다.
         */
        self.contentSizeObservation = self.recommendTableView.observe(
            \.contentSize,
             changeHandler: { [weak self] tableView, _ in
                 self?.tableViewHeightConstraint.constant = tableView.contentSize.height
             })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoListItemCell.identifier, for: indexPath)
        return cell
    }
}

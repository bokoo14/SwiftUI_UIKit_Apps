//
//  HomeViewController.swift
//  KTV
//
//  Created by Bokyung on 7/27/24.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let homeViewModel: HomeViewModel = .init()

    // status bar 색상 변경
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
    }

    func setupTableView() {
        self.tableView.register(
            UINib(nibName: HomeHeaderCell.identifier, bundle: .main),
            forCellReuseIdentifier: HomeHeaderCell.identifier
        )
        self.tableView.register(
            UINib(nibName: HomeVideoCell.identifier, bundle: .main),
            forCellReuseIdentifier: HomeVideoCell.identifier
        )
        self.tableView.register(
            UINib(nibName: HomeRankingContainerCell.identifier, bundle: .main),
            forCellReuseIdentifier: HomeRankingContainerCell.identifier)
        self.tableView.register(
            UINib(nibName: HomeRecentWatchContainerCell.identifier, bundle: .main),
            forCellReuseIdentifier: HomeRecentWatchContainerCell.identifier)
        self.tableView.register(
            UINib(nibName: HomeRecommendContainerCell.identifier, bundle: .main),
            forCellReuseIdentifier: HomeRecommendContainerCell.identifier
        )
        self.tableView.register(
            UINib(nibName: HomeFooterCell.identifier, bundle: .main),
            forCellReuseIdentifier: HomeFooterCell.identifier
        )
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "empty")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

/**
 extension으로 protocol구현을 나눈 이유: 가독성
 protocol을 나눠놓은 함수가 다른 상속한 클래스에서 사용해야 한다면, class선언부에 들어가 있어야 한다
 즉, extension에 구현된 함수는 상속받을 수 없다.
 */
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        HomeSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else {
            return 0
        }
        switch section {
        case .header:
            return 1
        case .video:
            return 2
        case .ranking:
            return 1
        case .recentWatch:
            return 1
        case .recommend:
            return 1
        case .footer:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return 0
        }

        switch section {
        case .header:
            return HomeHeaderCell.height
        case .video:
            return HomeVideoCell.height
        case .ranking:
            return HomeRankingContainerCell.height
        case .recentWatch:
            return HomeRecentWatchContainerCell.height
        case .recommend:
            return HomeRecommendContainerCell.height
        case .footer:
            return HomeFooterCell.height
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)
        }

        switch section {
        case .header:
            return tableView.dequeueReusableCell(
                withIdentifier: HomeHeaderCell.identifier,
                for: indexPath
            )
        case .video:
            return tableView.dequeueReusableCell(
                withIdentifier: HomeVideoCell.identifier,
                for: indexPath
            )
        case .ranking:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeRankingContainerCell.identifier,
                for: indexPath
            )
            (cell as? HomeRankingContainerCell)?.delegate = self
            return cell
        case .recentWatch:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeRecentWatchContainerCell.identifier,
                for: indexPath
            )
            (cell as? HomeRecentWatchContainerCell)?.delegate = self
            return cell
        case .recommend:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeRecommendContainerCell.identifier,
                for: indexPath
            )
            (cell as? HomeRecommendContainerCell)?.delegate = self
            return cell
        case .footer:
            return tableView.dequeueReusableCell(
                withIdentifier: HomeFooterCell.identifier,
                for: indexPath
            )

        }
    }
}

/**
 위임자(Delegator): HomeRecommendContainerCell 클래스. 이 클래스는 테이블 뷰 셀에서 선택 이벤트가 발생할 때 delegate에게 이를 알리는 역할을 한다.
 위임받는자(Delegate): HomeRecommendContainerCellDelegate 프로토콜을 준수하는 외부 객체. 일반적으로 뷰 컨트롤러가 이 역할을 수행한다.
 */
extension HomeViewController: HomeRecommendContainerCellDelegate {
    func homeRecommendContainerCell(_ cell: HomeRecommendContainerCell, didSelectItemAt index: Int) {
        print("home recommend cell did select item at \(index)")
    }
}

extension HomeViewController: HomeRankingContainerCellDelegate {
    func homeRankingContainerCell(_ cell: HomeRankingContainerCell, didSelectItemAt index: Int) {
        print("home ranking did select at \(index)")
    }
}

extension HomeViewController: HomeRecentWatchContainerCellDelegate {
    func homeRecentWatchContainerCell(_ cell: HomeRecentWatchContainerCell, didSelectItemAt index: Int) {
        print("home recent watch did select at \(index)")
    }
}

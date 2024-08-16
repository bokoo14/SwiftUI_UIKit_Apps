//
//  HomeViewController.swift
//  KTV
//
//  Created by Bokyung on 7/27/24.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private let homeViewModel: HomeViewModel = .init()

    // status bar 색상 변경
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupCollectionView()
        self.bindViewModel()
        self.homeViewModel.requestData()
    }

    func setupCollectionView() {
        // tableView -> collectionView
        self.collectionView.register(
            UINib(nibName: HomeHeaderView.identifier, bundle: .main),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeHeaderView.identifier
        )

        self.collectionView.register(
            UINib(nibName: HomeVideoCell.identifier, bundle: .main),
            forCellWithReuseIdentifier: HomeVideoCell.identifier
        )

        self.collectionView.register(
            UINib(nibName: HomeRankingHeaderView.identifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeRankingHeaderView.identifier
        )

        self.collectionView.register(
            UINib(nibName: HomeRankingContainerCell.identifier, bundle: .main),
            forCellWithReuseIdentifier: HomeRankingContainerCell.identifier)

        self.collectionView.register(
            UINib(nibName: HomeRecentWatchContainerCell.identifier, bundle: .main),
            forCellWithReuseIdentifier: HomeRecentWatchContainerCell.identifier)

        self.collectionView.register(
            UINib(nibName: HomeRecommendContainerCell.identifier, bundle: .main),
            forCellWithReuseIdentifier: HomeRecommendContainerCell.identifier
        )

        self.collectionView.register(
            UINib(nibName: HomeFooterView.identifier, bundle: .main),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: HomeFooterView.identifier
        )
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "empty")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.collectionView.isHidden = true
    }

    private func bindViewModel() {
        self.homeViewModel.dataChanged = { [weak self] in
            self?.collectionView.isHidden = false
            self?.collectionView.reloadData()
        }
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    // 여백 처리 - Header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let section = HomeSection(rawValue: section) else {
            return .zero
        }

        switch section {
        case .header:
            return CGSize(width: collectionView.frame.width, height: HomeHeaderView.height)
        case .ranking:
            return CGSize(width: collectionView.frame.width, height: HomeRankingHeaderView.height)
        case .video, .recentWatch, .recommend, .footer:
            return .zero
        }
    }

    // 여백 처리 - Footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let section = HomeSection(rawValue: section) else {
            return .zero
        }

        switch section {
        case .footer:
            return CGSize(width: collectionView.frame.width, height: HomeFooterView.height)
        case .header, .ranking, .video, .recentWatch, .recommend:
            return .zero
        }
    }

    // section마다 inset 처리
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let section = HomeSection(rawValue: section) else {
            return .zero
        }

        return self.insetForSection(section)
    }

    // minimumLineSpacingForSectionAt: line간의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let section = HomeSection(rawValue: section) else {
            return 0
        }

        switch section {
        case .header, .footer:
            return 0
        case .video, .ranking, .recentWatch, .recommend:
            return 21
        }
    }

    // size 계산 - width, height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return .zero
        }

        let inset = self.insetForSection(section)
        let width = collectionView.frame.width - inset.left - inset.right

        switch section {
        case .header, .footer:
            return .zero
        case .video:
            return .init(width: width, height: HomeVideoCell.height)
        case .ranking:
            return .init(width: width, height: HomeRankingContainerCell.height)
        case .recentWatch:
            return .init(width: width, height: HomeRecentWatchContainerCell.height)
        case .recommend:
            return .init(
                width: width,
                height: HomeRecommendContainerCell.height(viewModel: self.homeViewModel.recommendViewModel)
            )
        }
    }

    private func insetForSection(_ section: HomeSection) -> UIEdgeInsets {
        switch section {
        case .header, .footer:
            return .zero
        case .video, .ranking, .recentWatch, .recommend:
            return .init(top: 0, left: 21, bottom: 21, right: 21)
        }
    }

}

/**
 extension으로 protocol구현을 나눈 이유: 가독성
 protocol을 나눠놓은 함수가 다른 상속한 클래스에서 사용해야 한다면, class선언부에 들어가 있어야 한다
 즉, extension에 구현된 함수는 상속받을 수 없다.

 UITableViewDelegate, UITableViewDataSource -> UICollectionViewDelegateFlowLayout
 */
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        HomeSection.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else {
            return 0
        }
        switch section {
        case .header:
            return 0
        case .video:
            return self.homeViewModel.home?.videos.count ?? 0
        case .ranking:
            return 1
        case .recentWatch:
            return 1
        case .recommend:
            return 1
        case .footer:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return .init()
        }
        switch section {
        case .header:
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeHeaderView.identifier,
                for: indexPath
            )
        case .ranking:
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeRankingHeaderView.identifier,
                for: indexPath
            )
        case .footer:
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeFooterView.identifier,
                for: indexPath
            )
        case .video, .recentWatch, .recommend:
            return .init()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "empty", for: indexPath)
        }

        switch section {
        case .header, .footer:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "empty",
                for: indexPath
            )
        case .video:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeVideoCell.identifier,
                for: indexPath
            )

            if
                let cell = cell as? HomeVideoCell,
                let data = self.homeViewModel.home?.videos[indexPath.item] {
                cell.setData(data)
            }

            return cell
        case .ranking:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeRankingContainerCell.identifier,
                for: indexPath
            )

            if
                let cell = cell as? HomeRankingContainerCell,
                let data = self.homeViewModel.home?.rankings {
                cell.setData(data)
            }

            (cell as? HomeRankingContainerCell)?.delegate = self

            return cell
        case .recentWatch:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeRecentWatchContainerCell.identifier,
                for: indexPath
            )

            if
                let cell = cell as? HomeRecentWatchContainerCell,
                let data = self.homeViewModel.home?.recents {
                cell.delegate = self
                cell.setData(data)
            }

            return cell
        case .recommend:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeRecommendContainerCell.identifier,
                for: indexPath
            )

            if
                let cell = cell as? HomeRecommendContainerCell {
                cell.delegate = self
                cell.setViewModel(self.homeViewModel.recommendViewModel)
            }

            return cell
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

    /**
     UITableView vs UICollectionView
     - UITableView
     리스트 형식의 데이터 표시를 위한 뷰. 보통 행(row)단위로 데이터 표시
     reloadData(): UITableView의 데이터를 전면적으로 갱신
            reloadData()를 호출하면 데이블의 모든 셀을 다시 로드하고, 각 셀의 크기를 재계산하며, 뷰를 모두 제거한 후 다시 추가
            이 과정에서 모든 셀에 대해 'cellForRowAt' 메서드가 호출되며, 새로운 데이터를 기반으로 각 셀이 재구성됨
     리스트 전체가 새로고침되므로, 데이터가 바뀔 때 전체적으로 갱신해야 하는 경우 유용하지만, 많은 셀이 있을 때 성능에 영향을 줄 수 있음
     모든 셀의 뷰를 다시 로드하고 새로 그림. 데이터나 셀의 크기 등이 변경되었을 때 전체적으로 새로고침해야 하는 경우 사용

     - UICollectionView
     다양한 레이아웃 옵션으로 데이터를 표시할 수 있는 뷰. 보통 그리드 형식이나 커스텀 레이아웃을 만들 수 있음
     invalidateLayout(): 컬렉션 뷰의 레이아웃이 무효화되면서 다시 계산
            각 셀의 레이아웃(즉, 셀의 크기나 위치)만 다시 계산하며, 셀의 데이터 자체를 다시 로드하지 않음
            'cellForItemAt' 메서드는 다시 호출되지 않으며, 셀의 뷰는 그대로 유지된다.
     레이아웃만 변경하기 때문에 성능상 이점이 있으며, 셀의 내용이 아니라 레이아웃이 변경될 때 유용하다.
     셀의 크기가 동적으로 변경되거나, 컬렉션 뷰의 크기가 변할 때 유용하다.
     셀의 레이아웃만 다시 계산하며, 셀의 내용은 그대로 유지. 레이아웃이 변경되었을 때 성능을 최적화하는 데 유리
     */
    func homeRecommendContainerCellFoldChanged(_ cell: HomeRecommendContainerCell) {
        self.collectionView.collectionViewLayout.invalidateLayout()
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

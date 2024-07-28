//
//  HomeViewController.swift
//  KTV
//
//  Created by Bokyung on 7/27/24.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    // status bar 색상 변경
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
    }

    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(
            UINib(nibName: HomeVideoCell.identifier, bundle: nil),
            forCellReuseIdentifier: HomeVideoCell.identifier
        )
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
        case .video:
            return 2
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }

        switch section {
        case .video:
            return tableView.dequeueReusableCell(withIdentifier: HomeVideoCell.identifier, for: indexPath)
        }
    }
}

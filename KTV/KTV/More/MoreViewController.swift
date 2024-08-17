//
//  MoreViewController.swift
//  KTV
//
//  Created by Bokyung on 8/17/24.
//

import UIKit

class MoreViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!

    private let viewModel = MoreViewModel()

    /**
     init(nibName:bundle:): XIB 파일(또는 NIB 파일)로부터 뷰 컨트롤러를 초기화할 때 사용하는 생성자
     init(coder:): 스토리보드로부터 뷰 컨트롤러를 초기화할 때 사용
     */
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.modalPresentationStyle = .overFullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = MoreTableViewCell.rowHeight
        self.tableView.register(
            UINib(nibName: MoreTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: MoreTableViewCell.identifier)
        self.setupCornerRadius()
    }

    @IBAction func closeDidTap(_ sender: Any) {
        self.dismiss(animated: false)
    }

    private func setupCornerRadius() {
        let path = UIBezierPath(
            roundedRect: self.headerView.bounds,
            byRoundingCorners:  [.topLeft, .topRight],
            cornerRadii: CGSize(width: 13, height: 13)
        )

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.headerView.layer.mask = maskLayer
    }

}

extension MoreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoreTableViewCell.identifier, for: indexPath)

        if let cell = cell as? MoreTableViewCell {
            cell.setItem(self.viewModel.items[indexPath.row], separatorHidden: indexPath.row + 1 == self.viewModel.items.count)
        }
        return cell
    }
    

}

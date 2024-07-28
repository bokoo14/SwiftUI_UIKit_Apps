//
//  HomeRecommendContainerCell.swift
//  KTV
//
//  Created by Bokyung on 7/28/24.
//

import UIKit


/**
 위임자(Delegator): HomeRecommendContainerCell 클래스입니다. 이 클래스는 테이블 뷰 셀에서 선택 이벤트가 발생할 때 delegate에게 이를 알리는 역할을 한다.
 위임받는자(Delegate): HomeRecommendContainerCellDelegate 프로토콜을 준수하는 외부 객체이다.. 일반적으로 뷰 컨트롤러가 이 역할을 수행한다.

 delegate패턴을 통해 'HomeRecommendContainerCell'의 셀이 선택되었을 대, 이 이벤트를 'ViewController'같은 외부 객체에 알릴 수 있다.
 'HomeRecommendContainerCell'은 이벤트 처리 로직을 외부에 위임하여 코드의 모듈화를 높이고, 재사용성을 향상시킨다.
 */

/**
 HomeRecommendContainerCell 내부에서 발생한 특정 이벤트를 외부에 알리기 위해 사용돤다.
 여기서 특정 이벤트란, 테이블 뷰 셀의 선택 이벤트이다.

 메서드 homeRecommendContainerCell: 어떤 셀에서 어떤 아이템이 선택되었는지를 외부 객체에 전달
 */
protocol HomeRecommendContainerCellDelegate: AnyObject {
    func homeRecommendContainerCell(_ cell: HomeRecommendContainerCell, didSelectItemAt index: Int)
}

/**
 이 테이블 뷰의 셀 선택 이벤트를 외부로 전달하기 위해 HomeRecommendContainerCellDelegate 프로토콜 사용
 delegate: 외부 객체를 참조할 약한 참조로 선언된 delegate이다.  이 delegate는 프로토콜을 준수하는 객체여야 합니다.
 */
class HomeRecommendContainerCell: UITableViewCell {

    static let identifier: String = "HomeRecommendContainerCell"

    static var height: CGFloat {
        let top: CGFloat = 84 - 6 // 첫번째 cell에서 bottom까지의 거리 - cell의 상단 여백
        let bottom: CGFloat = 68 - 6 // 마지막 cell첫번째 bottom까지의 거리 - cell의 하단 여백
        let footerInset: CGFloat = 51 // container -> footer 까지의 여백
        return HomeRecommendItemCell.height * 5 + top + bottom + footerInset
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var foldButton: UIButton!
    weak var delegate: HomeRecommendContainerCellDelegate?


    // 초기화 메서드로, Nib 파일에서 로드된 후 호출
    override func awakeFromNib() {
        super.awakeFromNib()

        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
        self.tableView.rowHeight = HomeRecommendItemCell.height
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(
            UINib(nibName: "HomeRecommendItemCell", bundle: .main),
            forCellReuseIdentifier: HomeRecommendItemCell.identifier
        )
    }


    @IBAction func foldButtonDidTap(_ sender: Any) {}
    
    // 셀의 선택 상태를 설정
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension HomeRecommendContainerCell: UITableViewDataSource, UITableViewDelegate {
    // 테이블 뷰의 섹션 당 행 수를 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    // 특정 인텍스 경로에 대한 셀을 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: HomeRecommendItemCell.identifier, for: indexPath)
    }

    // 특정 행이 선택되었을 때 호출. 이 메서드에서 delegate를 호출하여 이벤트를 외부에 전달
    /**
     [동작 원리]
     1. HomeRecommendContainerCell 클래스는 내부 테이블 뷰의 셀이 선택되었을 때 tableView(_:didSelectRowAt:) 메서드를 통해 이 이벤트를 감지
     2. 이 이벤트가 발생하면 self.delegate?.homeRecommendContainerCell(self, didSelectItemAt: indexPath.row) 코드가 실행되어 delegate(위임받는자)에게 이 사실을 알린다.
     3. delegate는 HomeRecommendContainerCellDelegate 프로토콜을 준수하는 객체로, 이 메서드를 구현하고 있어야 한다. 이 메서드가 호출되면 delegate 객체는 적절한 동작을 수행한다. 
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.homeRecommendContainerCell(self, didSelectItemAt: indexPath.row)
    }
}

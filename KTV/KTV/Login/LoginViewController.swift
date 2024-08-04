//
//  LoginViewController.swift
//  KTV
//
//  Created by Bokyung on 5/22/24.
//

import UIKit

class LoginViewController: UIViewController {

    // outlet: UI를 화면과 연결
    // 간혹 이름을 바꾸는 경우 referencing outlet이 잘못될 수 있으므로 확인 필요
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    /**
     viewDidLoad: 뷰 컨트롤러의 뷰가 메모리에 로드된 후에 호출
     보통 초기 설정이나 뷰를 초기화할 때 사용, 한 번만 호출되므로, 뷰가 화면에 표시될 때마다 반복적으로 수행될 필요가 없는 초기화 작업에 적합하다.

     한 번 호출: 뷰 컨트롤러의 뷰가 메모리에 로드될 때 한 번만 호출된다.
     초기 설정: 뷰의 초기 설정, 데이터 로드, 서브뷰 추가, 초기 레이아웃 설정 등을 수행한다.
     안전한 접근: 뷰가 메모리에 로드된 후 호출되므로, 뷰와 관련된 설정이나 프로퍼티 접근이 안전하다.

     [다른 라이프 사이클 메서드]
     viewDidLoad: 뷰 컨트롤러의 뷰가 처음 메모리에 로드된 후 한 번만 호출된다. 초기화 작업이나 한 번만 설정해야 하는 작업을 수행하는 데에 사용
     viewWillAppear: 뷰가 화면에 나타나기 직전에 호출됩니다. 뷰가 나타날 때마다 호출되므로, 뷰가 나타날 때마다 업데이트해야 하는 작업을 수행할 때 사용
     viewDidAppear: 뷰가 화면에 나타난 후에 호출. 뷰가 화면에 표시된 후 추가적인 설정이나 애니메이션을 시작할 때 사용
     viewWillDisappear: 뷰가 화면에서 사라지기 직전에 호출. 뷰가 사라지기 전에 수행해야 하는 정리 작업이나 상태 저장 작업을 수행할 때 사용
     viewDidDisappear: 뷰가 화면에서 사라진 후에 호출. 뷰가 사라진 후 추가적인 정리 작업을 수행할 때 사용
     viewWillLayoutSubviews: 뷰의 서브뷰가 레이아웃되기 전에 호출. 서브 뷰의 레이아웃이 변경되기 전에 추가적인 레이아웃 설정이 필요할 때 사용
     viewDidLayoutSubviews: 뷰의 서브뷰가 레이아웃된 후에 호출. 서브 뷰의 레이아웃이 완료된 후 추가적인 설정이 필요할 때 사용
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginButton.layer.cornerRadius = 19
        self.loginButton.layer.borderColor = UIColor(named: "main-brown")?.cgColor
        self.loginButton.layer.borderWidth = 1
    }


    @IBAction func buttonDidTap(_ sender: Any) {
        // window의 루트뷰를 tabbar로 변경
        self.view.window?.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabbar")
    }
}


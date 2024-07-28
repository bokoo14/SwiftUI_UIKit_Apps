//
//  TabBarController.swift
//  KTV
//
//  Created by Bokyung on 7/27/24.
//

import UIKit

class TabBarController: UITabBarController {

    // 회전 X, portrait만 보이도록 -> HomeViewController는 TabbarController의 child라서 회전이 됨
    // TabbarController에서 이 코드를 작성해야 함
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait}

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

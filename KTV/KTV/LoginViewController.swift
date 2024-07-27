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


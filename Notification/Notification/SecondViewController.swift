//
//  SecondViewController.swift
//  Notification
//
//  Created by Lecture on 2023/09/21.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         - Delegate (위임)
         1:1 관계: 위임(Delegate) 패턴은 한 객체가 다른 객체의 특정 이벤트를 수신하기 위해 설정되는 1:1 관계.  즉, 한 위임 객체는 하나의 위임 대리자만 가질 수 있음
         예시: UITableViewDelegate나 UITextFieldDelegate와 같은 위임 패턴.

         - NotificationCenter
         다수의 수신자: NotificationCenter는 다수의 객체가 같은 알림을 수신할 수 있는 1:다수(One-to-Many) 관계를 지원. 즉, 여러 객체가 동일한 알림을 수신할 수 있음
         예시: 여러 뷰 컨트롤러가 특정 알림을 수신하여 서로 다른 방식으로 처리할 수 있음
         */
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.notificationReceived(_:)),
            name: .second,
            object: nil
        )
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        guard let value = notification.userInfo?["value"] as? Int else {
            return
        }
        
        print("notification did received \(value) \(notification.name)")
    }
    
    @IBAction func notifySecond(_ sender: Any) {
        NotificationCenter.default.post(
            name: .second,
            object: self,
            userInfo: [
                "value": 2
            ]
        )
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

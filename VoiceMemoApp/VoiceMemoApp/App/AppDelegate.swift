//
//  AppDelegate.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 12/18/23.
//

import UIKit

// 앱에서 일어나는 상호작용, 시스템 로우 레벨에서 할 수 있는 것들을 컨트롤 가능
class AppDelegate: NSObject, UIApplicationDelegate {
    var notificationDelegate = NotificationDelegate()
    
    // 런치가 된 후 수행
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = notificationDelegate
        return true
    }
}

//
//  VoiceMemoAppApp.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 12/18/23.
//

import SwiftUI

@main
struct VoiceMemoAppApp: App {
    // UIKit의 appdelegate를 쓰기 위함
    // 앱의 선언부에서만 정의, 한번만 선언
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}

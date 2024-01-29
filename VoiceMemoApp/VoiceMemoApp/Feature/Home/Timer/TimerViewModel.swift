//
//  TimerViewModel.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 1/29/24.
//

import Foundation
import UIKit

class TimerViewModel: ObservableObject {
    @Published var isDisplaySetTimeView: Bool
    @Published var time: Time
    @Published var timer: Timer?
    @Published var timeRemaining: Int // 남은 시간
    @Published var isPaused: Bool // 타이머가 멈춰있는지
    var notificationService: NotificationService
    
    init(
        isDisplaySetTimeView: Bool = true,
        time: Time = .init(hours: 0, minutes: 0, seconds: 0),
        timer: Timer? = nil,
        timeRemaining: Int = 0,
        isPaused: Bool = false,
        notificationService: NotificationService = .init()
    ) {
        self.isDisplaySetTimeView = isDisplaySetTimeView
        self.time = time
        self.timer = timer
        self.timeRemaining = timeRemaining
        self.isPaused = isPaused
        self.notificationService = notificationService
    }
}

/// 비즈니스 로직
extension TimerViewModel {
    // 설정하기 버튼을 눌렀을때
    func settingBtnTapped() {
        isDisplaySetTimeView = false
        timeRemaining = time.convertedSeconds
        startTimer()
    }
    
    // 취소하기 버튼을 눌렀을때
    func cancelBtnTapped() {
        stopTimer()
        isDisplaySetTimeView = true
    }
    
    // 일시정지 버튼 혹은 재시작 버튼을 눌렀을때
    func pauseOrRestartBtnTapped() {
        if isPaused {
            startTimer()
        } else {
            timer?.invalidate()
            timer = nil
        }
        isPaused.toggle()
    }
}

// 시작, 종료 메서드는 뷰에서 호출하는 것이 아니라 내부에서만 호출하는 것이기 때문에 private으로 호출
private extension TimerViewModel {
    // 타이머 시작 메서드
    func startTimer() {
        guard timer == nil else { return }
        
        // 앱이 백그라운드로 전환되었을때 작업을 수행할 수 있도록 해줌
        var backgroundTaskID: UIBackgroundTaskIdentifier?
        backgroundTaskID = UIApplication.shared.beginBackgroundTask {
            if let task = backgroundTaskID {
                UIApplication.shared.endBackgroundTask(task)
                backgroundTaskID = .invalid
            }
        }
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { _ in
            // 1초가 지날때마다 수행되는 로직
            // 시간이 남았다면
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
            // 남은 시간이 없다면
            else {
                self.stopTimer()
                self.notificationService.sendNotification()
                
                if let task = backgroundTaskID {
                    UIApplication.shared.endBackgroundTask(task)
                    backgroundTaskID = .invalid
                }
            }
        }
    }
    
    // 타이머 종료 메서드
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}


//
//  HomeViewModel.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 12/26/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var selectedTab: Tab // 현재 선택되어 있는 탭이 무엇인지
    @Published var todosCount: Int
    @Published var memosCount: Int
    @Published var voiceRecordersCount: Int
    
    init(
        selectedTab: Tab = .voiceRecorder,
        todosCount: Int = 0,
        memosCount: Int = 0,
        voiceRecordersCount: Int = 0
    ) {
        self.selectedTab = selectedTab
        self.todosCount = todosCount
        self.memosCount = memosCount
        self.voiceRecordersCount = voiceRecordersCount
    }
}


extension HomeViewModel {
    func setTodosCount(_ count: Int) {
        todosCount = count
    }
    
    func setMemosCount(_ count: Int) {
        memosCount = count
    }
    
    func setVoiceRecordersCount(_ count: Int) {
        voiceRecordersCount = count
    }
    
    // Tab 변경 메서드
    func changeSelectedTab(_ tab: Tab) {
        selectedTab = tab
    }
}


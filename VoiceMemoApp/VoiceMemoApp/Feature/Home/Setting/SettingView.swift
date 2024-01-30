//
//  SettingView.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 1/29/24.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            // 타이틀 뷰
            TitleView()
            Spacer()
                .frame(height: 35)
            // 총 탭 카운트 뷰
            TotalTabCountView()
            Spacer()
                .frame(height: 40)
            // 총 탭 무브 뷰
            TotalTabMoveView()
            Spacer()
        } // VStack
    }
}

// MARK: 타이틀 뷰
private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("설정")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.customBlack)
            
            Spacer()
        } // HStack
        .padding(.horizontal, 30)
        .padding(.top, 45)
    }
}

// MARK: 전체 탭 설정된 카운트 뷰
private struct TotalTabCountView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    fileprivate var body: some View {
        // 각각 탭 카운트 뷰(todolist, 메모장, 음성메모)
        HStack {
            Spacer()
            TabCountView(title: "To do", count: homeViewModel.todosCount)
            Spacer()
                .frame(width: 70)
            TabCountView(title: "메모", count: homeViewModel.memosCount)
            Spacer()
                .frame(width: 70)
            TabCountView(title: "음성메모", count: homeViewModel.voiceRecordersCount)
            Spacer()
        } // HStack
    }
}

// MARK: 각 탭 설정된 카운트 뷰 (공통 뷰 컴포넌트)
private struct TabCountView: View {
    private var title: String
    private var count: Int
    
    fileprivate init(
        title: String,
        count: Int
    ) {
        self.title = title
        self.count = count
    }
    
    fileprivate var body: some View {
        VStack (spacing: 5) {
            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(.customBlack)
            
            Text("\(count)")
                .font(.system(size: 30, weight: .medium))
                .foregroundStyle(.customBlack)
        } // VStack
    }
}

// MARK: 전체 탭 이동 뷰
private struct TotalTabMoveView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    fileprivate var body: some View {
        VStack {
            Rectangle()
                .fill(.customGray1)
                .frame(height: 1)
            TabMoveView(title: "To do List") {
                homeViewModel.changeSelectedTab(.todoList)
            }
            TabMoveView(title: "메모장") {
                homeViewModel.changeSelectedTab(.memo)
            }
            TabMoveView(title: "음성메모") {
                homeViewModel.changeSelectedTab(.voiceRecorder)
            }
            TabMoveView(title: "타이머") {
                homeViewModel.changeSelectedTab(.timer)
            }
            Rectangle()
                .fill(.customGray1)
                .frame(height: 1)
        }
    }
}

// MARK: 각 탭 이동 뷰
private struct TabMoveView: View {
    private var title: String
    private var tabAction: () -> Void
    
    fileprivate init(
        title: String,
        tabAction: @escaping () -> Void
    ) {
        self.title = title
        self.tabAction = tabAction
    }
    
    fileprivate var body: some View {
        Button {
            tabAction()
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundStyle(.customBlack)
                Spacer()
                Image("arrowRight")
            }
        }
        .padding(.all, 20)
    }
}

#Preview {
    SettingView()
        .environmentObject(HomeViewModel())
}

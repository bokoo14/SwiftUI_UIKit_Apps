//
//  OnboardingView.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 12/18/23.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var pathModel = PathModel()
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @StateObject private var todoListViewModel = TodoListViewModel()
    @StateObject private var memoListViewModel = MemoListViewModel()
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            // root
//            MemoListView()
//                .environmentObject(memoListViewModel)
            VoiceRecorderView()
            //OnboardingContentView(onboardingViewModel: onboardingViewModel)
                .navigationDestination(for: PathType.self) { pathType in
                    switch pathType {
                    case .homeView:
                        HomeView()
                            .navigationBarBackButtonHidden()
                    case .todoView:
                        TodoView()
                            .navigationBarBackButtonHidden()
                            .environmentObject(todoListViewModel)
                    case let .memoView(isCreateMode, memo):
                        MemoView(
                            memoViewModel: isCreateMode
                            ? .init(memo: .init(title: "", content: "", date: .now))
                            : .init(memo: memo ?? .init(title: "", content: "", date: .now)),
                            isCreateMode: isCreateMode)
                        .navigationBarBackButtonHidden()
                        .environmentObject(memoListViewModel)
                    }
                }
        } // NavigationStack
        .environmentObject(pathModel) // path를 전역적으로 사용가능
    }
}

// MARK: 온보딩 컨텐츠 뷰
private struct OnboardingContentView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    
    fileprivate init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            // 온보딩 셀리스트 뷰
            OnboardingCellList(onboardingViewModel: onboardingViewModel)
            Spacer()
            StartBtnView()
            // 시작 버튼 뷰
        }
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: 온보딩 셀 리스트 뷰
private struct OnboardingCellList: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    @State private var selectedIndex: Int
    
    fileprivate init(onboardingViewModel: OnboardingViewModel, selectedIndex: Int = 0) {
        self.onboardingViewModel = onboardingViewModel
        self.selectedIndex = selectedIndex
    }
    
    fileprivate var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(Array(onboardingViewModel.onboardingContents.enumerated()), id: \.element) { index, onboardingContent in
                OnbordingCellView(onboardingContent: onboardingContent)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
        .background(selectedIndex % 2 == 0 ? Color.customSky : Color.customBackgroundGreen)
        .clipped()
    }
}

// MARK: 온보딩 셀 뷰
private struct OnbordingCellView: View {
    private var onboardingContent: OnboardingContent
    
    fileprivate init(onboardingContent: OnboardingContent) {
        self.onboardingContent = onboardingContent
    }

    fileprivate var body: some View {
        VStack(spacing: 0) {
            Image(onboardingContent.imageFileName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(radius: 10)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 5) {
                        Text(onboardingContent.title)
                            .font(.system(size: 16, weight: .bold))
                        Text(onboardingContent.subTitle)
                            .font(.system(size: 16))
                    } // VStack: title, subTitle
                    .padding(.top, 46)
                    Spacer()
                }
                //Spacer()
            } // VStack: 하단 Area
            .background(Color.customWhite)
            .clipShape(Rectangle())
            .shadow(radius: 10)
        } // VStack
        .ignoresSafeArea()
    }
}

/// 시작하기 버튼
private struct StartBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        Button {
            // action
            pathModel.paths.append(.homeView)
        } label: {
            HStack (spacing: 10){
                Text("시작하기")
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 64, height: 19)
                Image("startHome")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24)
            }
            .foregroundStyle(.customGreen)
            .padding(.horizontal, 9)
        }
        .padding(.bottom, 50)

    }
}



#Preview {
    OnboardingView()
}

#Preview {
    OnboardingCellList(onboardingViewModel: OnboardingViewModel(onboardingContents: [OnboardingContent(imageFileName: "onboarding_1", title: "오늘의 할일", subTitle:  "To do list로 언제 어디서든 해야할 일을 한눈에!"), OnboardingContent(imageFileName: "onboarding_1", title: "오늘의 할일", subTitle:  "To do list로 언제 어디서든 해야할 일을 한눈에!")]))
}


#Preview {
    OnbordingCellView(onboardingContent: OnboardingContent(imageFileName: "onboarding_1", title: "오늘의 할일", subTitle:  "To do list로 언제 어디서든 해야할 일을 한눈에!"))
}


#Preview {
    StartBtnView()
}

// NOTE: 📝
/**
 하위 뷰를 많이 쪼개는 데에 이점이 있다
 뷰가 계산하기 어려워지거나 스택을 쌓는 데에 버벅인다면 빌드가 안되기떄문
 프리뷰에서도 버벅이고 보이지 않는 문제가 발생하기도 한다
 */

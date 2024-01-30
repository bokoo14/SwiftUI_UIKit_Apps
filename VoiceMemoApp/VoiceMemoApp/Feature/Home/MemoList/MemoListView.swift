//
//  MemoListView.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 12/22/23.
//

import SwiftUI

struct MemoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if !memoListViewModel.memos.isEmpty {
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        rightBtnAction: {
                            memoListViewModel.navigationRightBtnTapped()
                        },
                        rightBtnType: memoListViewModel.navigationBarRightBtnMode
                    )
                } else {
                    Spacer()
                        .frame(height: 30)
                }
                
                TitleView()
                    .padding(.top, 20)
                
                if memoListViewModel.memos.isEmpty {
                    AnnouncementView()
                } else {
                    MemoListContentView()
                        .padding(.top, 20)
                        .padding(.bottom, 50)
                }
            } // VStack
            
            WriteMemoBtnView()
                .padding(.trailing, 20)
        } // ZStack
        .alert(
            LocalizedStringKey(stringLiteral: "메모 \(memoListViewModel.removeMemoCount)개 삭제하시겠습니까?"),
            isPresented: $memoListViewModel.isDisplayRemoveMemoAlert
        ) {
            Button("삭제", role: .destructive) { memoListViewModel.removeBtnTapped() }
            Button("취소", role: .cancel) { }
        } // alert
        // memoList의 값이 변경될때마다 개수를 받아와서 업데이트
        .onChange(of: memoListViewModel.memos) { memos in
            homeViewModel.setMemosCount(memos.count)
        } // onChange
    }
}

// MARK: 타이틀 뷰
private struct TitleView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    fileprivate var body: some View {
        HStack {
            if memoListViewModel.memos.isEmpty {
                Text("메모를 추가해보세요.")
            } else {
                Text("메모 \(memoListViewModel.memos.count)개가\n있습니다.")
            }
            Spacer()
        } // HStack
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

// MARK: 안내 뷰
private struct AnnouncementView: View {
    fileprivate var body: some View {
        VStack(spacing: 15) {
            Spacer()
            Image("pencil")
                .renderingMode(.template)
            Text("\"퇴근 9시간 전 메모\"")
            Text("\"개발 끝낸 후 퇴근하기!\"")
            Text("\"밀린 알고리즘 공부하기!\"")
            Spacer()
        } // VStack
        .font(.system(size: 16))
        .foregroundStyle(.customGray2)
    }
}

// MARK: 메모 리스트 컨텐츠 뷰

private struct MemoListContentView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("메모 목록")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 20)
                Spacer()
            } // HStack
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(.customGray0)
                        .frame(height: 1)
                    
                    ForEach(memoListViewModel.memos, id: \.self) { memo in
                        MemoCellView(memo: memo)
                    }
                }
            } // ScrollView
        } // VStack
    }
}

// MARK: 메모 셀 뷰
private struct MemoCellView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @State private var isRemoveSelected: Bool
    private var memo: Memo
    
    fileprivate init(
        isRemoveSelected: Bool = false,
        memo: Memo
    ) {
        // TODO: 이 문법에 대해 공부!!
        _isRemoveSelected = State(initialValue: isRemoveSelected)
        self.memo = memo
    }
    
    fileprivate var body: some View {
        Button(
            action: {
                pathModel.paths.append(.memoView(isCreateMode: false, memo: memo))
            },
            label: {
                VStack(spacing: 10) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(memo.title)
                                .lineLimit(1)
                                .font(.system(size: 16))
                                .foregroundStyle(.customBlack)
                            Text(memo.content)
                                .font(.system(size: 12))
                                .foregroundStyle(.customIconGray)
                        } // VStack
                        Spacer()
                        
                        if memoListViewModel.isEditMemoMode {
                            Button(
                                action: {
                                    isRemoveSelected.toggle()
                                    memoListViewModel.memoRemoveSelectedBoxTapped(memo)
                                },
                                label: {
                                    isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox")
                                })
                        }
                    } // HStack
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    
                    Rectangle()
                        .fill(.customGray0)
                        .frame(height: 1)
                } // VStack
        })
    }
}


// MARK: 메모 작성 버튼 뷰
private struct WriteMemoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    pathModel.paths.append(.memoView(isCreateMode: true, memo: nil))
                }, label: {
                    Image("writeBtn")
                })
            } // HStack
        } // VStack
    }
}

#Preview {
    MemoListView()
        .environmentObject(PathModel())
        .environmentObject(MemoListViewModel())
}

#Preview {
    MemoCellView(memo: Memo(title: "sass", content: "sasadasads", date: Date()))
        .environmentObject(PathModel())
        .environmentObject(MemoListViewModel())
}

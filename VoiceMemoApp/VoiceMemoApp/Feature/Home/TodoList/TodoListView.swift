//
//  TodoListView.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 12/21/23.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    var body: some View {
        ZStack {
            // todo cell list
            VStack(spacing: 0) {
                // 상단의 CustomNavigationBar
                if !todoListViewModel.todos.isEmpty {
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        rightBtnAction: {
                            todoListViewModel.navigationRightBtnTapped()
                        },
                        rightBtnType: todoListViewModel.navigationBarRightBtnMode
                    )
                } else {
                    Spacer()
                        .frame(height: 30)
                }
                
                
                TitleView()
                    .border(.purple)
                if todoListViewModel.todos.isEmpty {
                    AnnouncementView()
                        .border(.cyan)
                } else {
                    TodoListContentView()
                }
                
                
            } // VStack
            .border(.green)
            
            WriteTodoBtnView()
                .padding(.trailing, 20)
                .padding(.bottom, 50)
        } // ZStack
        .alert(LocalizedStringKey(stringLiteral: "To do list \(todoListViewModel.removeTodosCount)개 삭제하시겠습니까?"), 
               isPresented: $todoListViewModel.isDisplayRemoveTodoAlert,
               actions: {
            Button(role: .destructive) { todoListViewModel.removeBtnTapped() } label: { Text("삭제") }
            Button(role: .cancel) { } label: { Text("취소") }
        }, message: { })
    }
}

// MARK: TodoList 타이틀 뷰
private struct TitleView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    fileprivate var body: some View {
        HStack(spacing: 0) {
            if todoListViewModel.todos.isEmpty {
                Text("To do list를\n추가해 보세요.")
            } else {
                Text("To do list \(todoListViewModel.todos.count)개가\n있습니다.")
            }
            Spacer()
        } // HStack
        .font(.system(size: 30, weight: .bold))
        .padding(.horizontal, 30)
        .border(.red)
    }
}

// MARK: TodoList 안내 뷰
private struct AnnouncementView: View {
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            Image("pencil")
                .renderingMode(.template)
                .border(.red)
                .frame(width: 80, height: 48)
                .border(.red)
            Text("\"매일 아침 5시 운동가라고 알려줘\"\n\"내일 8시 수강 신청하라고 알려줘\"\n\"1tl 반 점심약속 리마인드 해줘\"")
                .lineSpacing(8.0)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .font(.system(size: 14, weight: .regular))
        .foregroundStyle(.customGray2)
    }
}

// MARK: TodoList 컨텐츠 뷰
private struct TodoListContentView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    fileprivate var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 0) {
                Text("할일 목록")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 16)
                Spacer()
            } // HStack
            .padding(.horizontal, 30)
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(.customGray0)
                        .frame(height: 1)
                    
                    ForEach(todoListViewModel.todos, id: \.self) { todo in
                        TodoCellView(todo: todo)
                    }
                }
            } // ScrollView
        } // VStack
    }
}

// MARK: Todo 셀 뷰
private struct TodoCellView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @State private var isRemoveSelected: Bool
    private var todo: Todo
    
    init(
        isRemoveSelected: Bool = false,
        todo: Todo
    ) {
        _isRemoveSelected = State(initialValue: isRemoveSelected)
        self.todo = todo
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 19) {
                // edit모드가 아니라면
                if !todoListViewModel.isEditTodoMode {
                    Button(action: { todoListViewModel.selectedBoxTapped(todo) }, label: {
                        todo.selected ? Image("selectedBox") : Image("unSelectedBox")
                    })
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(todo.title)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(todo.selected ? .customIconGray : .customBlack)
                        .strikethrough(todo.selected)
                    Text(todo.convertedDayAndTime)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.customIconGray)
                } // VStack
                
                Spacer()
                
                // edit모드라면
                if todoListViewModel.isEditTodoMode {
                    Button(action: {
                        isRemoveSelected.toggle()
                        todoListViewModel.todoRemoveSelectedBoxTapped(todo)
                    }, label: {
                        isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox")
                    })
                }
            } // HStack
            .padding(.horizontal, 20)
            .padding(.vertical, 25)
            
            Rectangle()
                .fill(.customGray0)
                .frame(height: 1)
        } // VStack
    }
}


// MARK: Todo 작성 버튼 뷰
private struct WriteTodoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: { pathModel.paths.append(.todoView) },
                       label: { Image("writeBtn") })
            } // HStack
        } // VStack
    }
}


#Preview {
    TodoListView()
        .environmentObject(PathModel())
        .environmentObject(TodoListViewModel())
}


#Preview {
    TodoListContentView()
        .environmentObject(TodoListViewModel())
}

#Preview {
    TodoCellView(todo: Todo(title: "title", time: Date.now, day: Date.now, selected: false))
        .environmentObject(TodoListViewModel())
}

// NOTE: 📝
/**
 하위 뷰를 만드는 방법
 스타일의 차이
 프로퍼티나 메서드로 사용하게 된다면, environmentObject나 StateObject를 바로 사용할 수 있다는 장점
 다른 구조체로 사용하게 된다면 주입을 받아야 하기 떄문에 프로터티나 메서드로 사용하는 것을 선호
 구조체를 사용할때는, 다른 뷰에서도 사용할 수 있어서 컴포넌트처럼 사용 가능
 
 1. 프로퍼티
 var titleView: some View {
 Text("title")
 }
 
 2. 메서드
 func titleView2() -> some View {
 Text("Title")
 }
 
 3. 구조체
 
 */

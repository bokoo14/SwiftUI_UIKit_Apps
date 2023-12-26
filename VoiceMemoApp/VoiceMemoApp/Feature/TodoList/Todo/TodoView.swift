//
//  TodoView.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 12/21/23.
//

import SwiftUI

struct TodoView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @StateObject private var todoViewModel = TodoViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                isDisplayLeftBtn: true,
                isDisplayRightBtn: true,
                leftBtnAction: {
                    pathModel.paths.removeLast()
                },
                rightBtnAction: {
                    todoListViewModel.addTodo(Todo(title: todoViewModel.title, time: todoViewModel.time, day: todoViewModel.day, selected: false))
                },
                rightBtnType: .create
            )
            
           
            VStack(spacing: 21) {
                TitleView()
                    .padding(.top, 20)
                TodoTitleView(todoViewModel: todoViewModel)
            }
            .padding(.horizontal, 30)
            
            VStack(spacing: 21) {
                SelectTimeView(todoViewModel: todoViewModel)
                SelectDayView(todoViewModel: todoViewModel)
                    .padding(.horizontal, 30)
            }
            
            Spacer()
        } // VStack
    }
}


// MARK: 타이틀 뷰
private struct TitleView: View {
    fileprivate var body: some View {
        HStack(spacing: 0) {
            Text("To do list를\n추가해 보세요.")
                .font(.system(size: 30, weight: .bold))
            Spacer()
        } // HStack
    }
}

// MARK: todo titleView (제목 입력 뷰)
private struct TodoTitleView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        TextField(text: $todoViewModel.title) {
            Text("제목을 입력하세요.")
                .font(.system(size: 16, weight: .regular))
        }
        .frame(height: 38)
    }
}

// MARK: 시간 선택 뷰
private struct SelectTimeView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.customGray0)
                .frame(height: 1)
            
            DatePicker(
                "",
                selection: $todoViewModel.day,
                displayedComponents: [.hourAndMinute]
            )
            .labelsHidden()
            .datePickerStyle(.wheel)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Rectangle()
                .fill(.customGray0)
                .frame(height: 1)
            
        } // VStack
    }
}

// MARK: 날짜 선택 뷰
private struct SelectDayView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    fileprivate var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 0) {
                Text("날짜")
                    .foregroundStyle(.customIconGray)
                Spacer()
            } // HStack
            
            HStack(spacing: 0) {
                Button(action: {
                    todoViewModel.setIsDisplayCalendar(true)
                }, label: {
                    Text("\(todoViewModel.day.formattedDay)")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.customGreen)
                })
                .popover(isPresented: $todoViewModel.isDisplayCalendar, content: {
                    DatePicker(selection: $todoViewModel.day, displayedComponents: .date) { }
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    // todoViewModel의 day값이 변경될때마다 로직 수행
                    // 날짜가 선택되면 popover가 닫히도록
                        .onChange(of: todoViewModel.day) { _ in
                            todoViewModel.setIsDisplayCalendar(false)
                        }
                }) // popover
                Spacer()
            } // HStack
        } // VStack
    }
}


#Preview {
    TodoView()
        .environmentObject(PathModel())
        .environmentObject(TodoListViewModel())
}

#Preview {
    TitleView()
}

#Preview {
    TodoTitleView(todoViewModel: TodoViewModel())
}

#Preview {
    SelectTimeView(todoViewModel: TodoViewModel())
}


#Preview {
    SelectDayView(todoViewModel: TodoViewModel())
}

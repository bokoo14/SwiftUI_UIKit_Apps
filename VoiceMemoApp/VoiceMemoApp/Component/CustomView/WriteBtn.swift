//
//  WriteBtn.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 1/30/24.
//

import SwiftUI

/// 뷰 모디파이어 생성 방법 3가지
// MARK: 1️⃣
public struct WriteBtnViewModifier: ViewModifier {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    // ViewModifier 프로토콜을 채택했으므로 필수 구현 메서드인 body를 구현해야 함
    public func body(content: Content) -> some View{
        ZStack {
            content
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        action()
                    }, label: {
                        Image("writeBtn")
                    })
                } // HStack
            } // VStack
            .padding(.trailing, 20)
            .padding(.bottom, 50)
        } // ZStack
    }
}

// MARK: 2️⃣
extension View {
    public func writeBtn(perform action: @escaping () -> Void) -> some View {
        ZStack {
            self // 뷰 자체에서 호출했으므로 self
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        action()
                    }, label: {
                        Image("writeBtn")
                    })
                } // HStack
            } // VStack
            .padding(.trailing, 20)
            .padding(.bottom, 50)
        } // ZStack
    }
}

// MARK: 3️⃣
public struct WriteBtnView<Content: View>: View {
    let content: Content
    let action: () -> Void
    public init(
        @ViewBuilder content: () -> Content,
        action: @escaping () -> Void
    ) {
        self.content = content()
        self.action = action
    }
    
    public var body: some View {
        ZStack {
            content
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        action()
                    }, label: {
                        Image("writeBtn")
                    })
                } // HStack
            } // VStack
            .padding(.trailing, 20)
            .padding(.bottom, 50)
        } // ZStack
    }
}



// WriteBtn 모디파이어 1️⃣
#Preview {
    VStack(spacing: 0) {
        Text("WriteBtn 모디파이어 1️⃣")
    } // VStack
    .modifier(WriteBtnViewModifier(action: {
        // action
    }))
}

// WriteBtn 모디파이어 2️⃣
#Preview {
    VStack(spacing: 0) {
        Text("WriteBtn 모디파이어 2️⃣")
    } // VStack
    .writeBtn(perform: {
        // action
    })
}

// WriteBtn 모디파이어 3️⃣
#Preview {
    WriteBtnView {
        VStack(spacing: 0) {
            Text("WriteBtn 모디파이어 3️⃣")
        } // VStack
    } action: {
        
    }
}

//
//  MemoViewModel.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 12/22/23.
//

import Foundation

class MemoViewModel: ObservableObject {
    @Published var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
    }
}

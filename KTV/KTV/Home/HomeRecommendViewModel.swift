//
//  HomeRecommendViewModel.swift
//  KTV
//
//  Created by Bokyung on 8/14/24.
//

import Foundation

class HomeRecommendViewModel {
    // private(set): 외부에서 이 속성의 값을 읽을 수는 있지만, 변경할 수는 없음
    private(set) var isFolded: Bool = true {
        /**
         didSet: 속성의 값이 설정된 후(변경된 후) 호출되는 감시자
         속성의 값이 변경된 직후 특정 동작을 수행하고 싶을 때
         */
        didSet {
            self.foldChanged?(self.isFolded)
        }
    }

    var foldChanged: ((Bool) -> Void)?

    var recommends: [Home.Recommend]?
    var itemCount: Int {
        let count = self.isFolded ? 5 : self.recommends?.count ?? 0

        return min(self.recommends?.count ?? 0, count)
    }

    func toggleFoldState() {
        self.isFolded.toggle()
    }
}

//
//  FavoriteViewModel.swift
//  KTV
//
//  Created by Bokyung on 8/16/24.
//

import Foundation
/**
 값 타입 vs 참조 타입
 - 구조체 (struct): 값 타입
 구조체의 인스턴스를 다른 변수에 할당하거나 함수에 전달할 때, 인스턴스의 복사본이 생성된다.
 이를 통해 변경이 독립적으로 이루어지며, 원본과 복사본이 서로 영향을 미치지 않는다.
 값 타입이므로, 주로 데이터 모델링에서 사용됨.
 값 타입을 사용하면 불변성(immutable)을 쉽게 유지할 수 있으며, 데이터가 독립적으로 관리되어야 하는 경우에 유용

 - 클래스 (class): 참조 타입
 클래스 인스턴스를 다른 변수에 할당하거나 함수에 전달할 때, 참조가 전달된다.
 따라서 두 변수는 같은 인스턴스를 참조하게 되며, 한쪽에서 변경하면 다른 쪽에도 영향을 미친다.
 상태를 공유하거나 여러 객체가 같은 데이터에 접근하고 수정할 필요가 있을 때 사용
 뷰 모델(View Model)이나 컨트롤러와 같은 상태를 관리하는 객체는 주로 클래스가 적합
 */
@MainActor class FavoriteViewModel {
    private(set) var favorite: Favorite?
    var dataChanged: (() -> Void)?

    func request() {
        Task {
            do {
                let favorite = try await DataLoader.load(url: URLDefines.favorite, for: Favorite.self)
                self.favorite = favorite
                self.dataChanged?()
            } catch {
                print("favorite load failed \(error.localizedDescription)")
            }
        }
    }
}

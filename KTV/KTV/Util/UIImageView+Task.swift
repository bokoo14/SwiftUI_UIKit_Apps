//
//  UIImageView+Task.swift
//  KTV
//
//  Created by Bokyung on 8/1/24.
//

import UIKit

extension UIImageView {


    /**
     loadImage: 네트워크를 통해 이미지를 가져오는 작업이 완료될 때까지 기다렸다가, 성공적으로 로드된 경우만 이미지를 설정
     Task<Void, Never>: 작업이 완료되면 Void반환, 오류를 발생시키지 않는 Never작업
     @discardableResult:  함수나 메서드의 반환값이 사용되지 않아도 경고를 발생시키지 않도록 하는 속성
     */
    @discardableResult
    func loadImage(url: URL) -> Task<Void, Never> {
        // return .init: Task 초기화 및 클로저 내부에서 비동기 작업 정의
        // Task는 비동기적으로 실행되는 작업을 관리하고, 그 작업이 완료되기를 기다릴 수 있음
        return .init {
            /**
             await: 작업이 완료되기를 기다림
             data(for:): 튜플 반환, 튜플의 첫 번째 요소인 responseData를 사용
             try?: 오류가 발생할 수 있는 작업을 안전하게 시도. 오류가 발생하면 'nil' 반환
             */
            guard
                let responseData = try? await URLSession.shared.data(for: .init(url: url)).0,
                let image = UIImage(data: responseData)
            else {
                return
            }

            // UIImageView의 image 속성에 할당
            self.image = image
        }
    }
}

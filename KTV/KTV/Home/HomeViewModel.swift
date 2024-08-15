//
//  HomeViewModel.swift
//  KTV
//
//  Created by Bokyung on 7/28/24.
//

import Foundation

/**
 @MainActor:  클래스 또는 메서드가 메인 스레드에서 실행되도록 보장하는 속성
 UI관련 작업은 항상 메인 스레드에서 이루어져야 한다

 HomeViewModel 클래스 내의 모든 메서드와 속성 접근이 메인 스레드에서 실행됨
 UI를 업데이터하거나 데이터를 설정하는 작업이 포함된 경우, 이를 통해 스레드 안정성을 보장함
 */
@MainActor class HomeViewModel {
    private(set) var home: Home?
    let recommendViewModel: HomeRecommendViewModel = .init()
    var dataChanged: (() -> Void)?

    func requestData() {
        /**
         Task: Swift에서 비동기 작업을 생성하는 데 사용
         await: 비동기 함수의 결과를 기다릴 수 있음
              비동기 함수가 완료될 때까지 현재 함수의 실행을 일시적으로 중단시키고, 작업이 완료된 후 실행을 재개
              await 키워드는 async로 표시된 비동기 함수 안에서만 사용 가능
              비동기 함수는 여러 작업을 병렬로 수행하고, 작업이 끝나기를 기다리면서 다른 작업을 진행할 수 있게 해줌
         try: 오류가 발생할 수 있는 상황을 처리
         catch: 네트워크 요청이나 JSON 파싱 중 오류가 발생했을 때 이를 처리
         */
//        Task {
//            do {
//                let home = try await DataLoader.load(url: URLDefines.home, for: Home.self)
//                self.home = home
//                // 네트워크 요청을 통해 가져온 home객체의 recommends 속성을 ViewModel에 할당
//                self.recommendViewModel.recommends = home.recommends
//                self.dataChanged?()
//            } catch {
//                print("json parsing failed: \(error.localizedDescription)")
//            }
//        }
        Task {
            do {
                print("Starting data request...")
                let home = try await DataLoader.load(url: URLDefines.home, for: Home.self)
                print("Data successfully loaded")

                // home 객체의 내용을 로그로 출력하여 확인
                print("Home data: \(home)")

                self.home = home

                self.recommendViewModel.recommends = home.recommends
                self.dataChanged?()

                print("Data processed successfully")
            } catch {
                // 오류 발생 시, 오류 메시지와 더불어 추가적인 정보를 출력
                print("json parsing failed: \(error.localizedDescription)")
                if let error = error as? DecodingError {
                    switch error {
                    case .typeMismatch(let type, let context):
                        print("Type mismatch: \(type), \(context.debugDescription)")
                    case .valueNotFound(let type, let context):
                        print("Value not found: \(type), \(context.debugDescription)")
                    case .keyNotFound(let key, let context):
                        print("Key not found: \(key), \(context.debugDescription)")
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context.debugDescription)")
                    @unknown default:
                        print("Unknown decoding error: \(error.localizedDescription)")
                    }
                } else {
                    print("Other error: \(error)")
                }
            }
        }

    }
}

//
//  DataLoader.swift
//  KTV
//
//  Created by Bokyung on 8/1/24.
//

import Foundation

struct DataLoader {
    // 공유 세션 사용
    private static let session: URLSession = .shared

    /**
     데이터 비동기적으로 로드
     T는 Decodable 프로토콜을 준수해야 함. 즉, T는 외부 데이터를 받아 객체로 변환할 수 있는 타입이어야 함
     async: 비동기 함수 (네트워크 요청과 같은 시간이 걸리는 작업을 처리하는 동안 다른 작업을 계속할 수 있게 함)
     throws: 오류가 발생할 수 있음
     */
    static func load<T: Decodable>(url: String, for type: T.Type) async throws -> T {
        // 변환 실패 시, 에러를 던짐
        guard let url = URL(string: url) else {
            throw URLError(.unsupportedURL)
        }

        /**
         self.session.data(for: init(url: url)): 지정된 url로 네티워크 요청을 보내고 데이터를 받아옴
         await: 비동기적으로 작업이 수행됨
         try: 오류 발생할 수 있음. 오류 발생 시 예외를 던져줌
         .0: data(for:) 메서드가 반환하는 튜플에서 데이터를 추출함
         */
        let data = try await self.session.data(for: .init(url: url)).0
        // 디코드 인스턴스를 생성하여, 로드된 데이터를 JSON 형식에서 swift객체로 변환
        let jsonDecoder = JSONDecoder()

        // decode(T.self, from: data)를 통해 데이터 타입 'T'로 디코딩. 디코딩 실패 시 예외 발생
        return try jsonDecoder.decode(T.self, from: data)
    }
}


/**
 URLSession.shared
 URLSession의 기본 인스턴스
 애플리케이션 전역에서 사용될 수 있으며, 새로운 설정이 필요 없는 일반적인 네트워크 요청에 적합

 shared를 사용하는 이유
 이미 설정되어 있는 기본 세션이기 때문에, 추가적인 설정없이 간편하게 사용 가능
 네트워크 요청을 수행하기 위해 별도의 세션을 생성할 필요 없이, 코드 한 줄로 작업 가능
 shared인스턴스는 애플리케이션에서 하나의 인스턴스로 공유되기 때문에, 메모리와 리소스 사용이 효율적임
 같은 설정으로 여러 번 세션을 생성하지 않아도 되므로, 시스템 자원을 절약할 수 있다
 shared 세션은 쿠키, 저장소, 캐시, 자격 증명 등의 기본 설정을 제공하며, 별도의 커스텀이 필요 없는 일반적인 네트워크 작업에 적합함
 */

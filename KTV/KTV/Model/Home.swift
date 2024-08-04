//
//  Home.swift
//  KTV
//
//  Created by Bokyung on 7/28/24.
//

import Foundation

/**
 Decodable이라는 interface를 confirm해야 json데이터를 제대로 matching할 수 있음
 */
struct Home: Decodable {
    let videos: [Video]
    let ranking: [Ranking]
    let recents: [Recent]
    let recommends: [Recommend]
}

extension Home {
    struct Video: Decodable {
        let videoId: Int
        let isHot: Bool
        let title: String
        let subtitle: String
        let imageURL: URL
        let channel: String
        let channelThumbnailURL: URL
        let channelDescription: String
    }

    struct Ranking: Decodable {
        let imageURL: URL
        let videoId: Int
    }

    struct Recent: Decodable {
        let imageURL: URL
        let timeStamp: Double
        let title: String
        let channel: String
    }

    struct Recommend: Decodable {
        let imageURL: URL
        let title: String
        let playtime: Double
        let channel: String
        let videoId: Int
    }
}
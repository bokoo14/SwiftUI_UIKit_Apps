//
//  Bookmark.swift
//  KTV
//
//  Created by Bokyung on 8/16/24.
//

import Foundation


struct Bookmark: Decodable {
    let channels: [Item]
}

extension Bookmark {
    struct Item: Decodable {
        let channel: String
        let channelId: Int
        let thumbnail: URL
    }
}

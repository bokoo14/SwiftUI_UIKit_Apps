//
//  VideoListItem.swift
//  KTV
//
//  Created by Bokyung on 8/16/24.
//

import Foundation

struct VideoListItem: Decodable {
    let imageUrl: URL
    let title: String
    let playtime: Double
    let channel: String
    let videoId: Int
}

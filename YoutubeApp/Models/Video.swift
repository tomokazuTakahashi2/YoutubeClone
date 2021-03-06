//
//  Video.swift
//  YoutubeApp
//
//  Created by Raphael on 2020/10/09.
//  Copyright © 2020 Raphael. All rights reserved.
//

import Foundation

class Video: Decodable {
    let kind: String
    let items: [Item]
}

class Item: Decodable {
    
    var channel: Channel?
    let snippet: Snippet
}

class Snippet: Decodable {
    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
    let thumbnails: Thumbnail
}

class Thumbnail: Decodable {
    let medium: ThumbnailInfo
    let high: ThumbnailInfo
}

class ThumbnailInfo: Decodable {
    let url: String
    let width: Int?
    let hight: Int?
}

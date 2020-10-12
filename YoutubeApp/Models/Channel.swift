//
//  Channel.swift
//  YoutubeApp
//
//  Created by Raphael on 2020/10/09.
//  Copyright © 2020 Raphael. All rights reserved.
//

import Foundation

class Channel: Decodable {
    let items: [ChannelItem]
}

class ChannelItem: Decodable {
    let snippet: ChannelSnippet
}

class ChannelSnippet: Decodable {
    //チャンネルのタイトル
    let title:String
    //チャンネルのサムネイル
    let thumbnails: Thumbnail
}

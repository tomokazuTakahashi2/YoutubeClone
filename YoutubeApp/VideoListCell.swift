//
//  VideoListCell.swift
//  YoutubeApp
//
//  Created by Raphael on 2020/10/08.
//  Copyright © 2020 Raphael. All rights reserved.
//

import UIKit
import Nuke

class VideoListCell: UICollectionViewCell {
    
    var videoItem: Item? {
        didSet {
            //動画サムネ画像の表示
            if let url = URL(string: videoItem?.snippet.thumbnails.medium.url ?? ""){
                //Nukeでカクツキをなくす
                Nuke.loadImage(with: url, into: thumbnailImageView)
            }
            //チャンネルアイコンの表示
            if let channelUrl = URL(string: videoItem?.channel?.items[0].snippet.thumbnails.medium.url ?? ""){
                //Nukeでカクツキをなくす
                Nuke.loadImage(with: channelUrl, into: channelImageView)
            }
            //タイトルの表示
            titleLabel.text = videoItem?.snippet.title
            //本文の表示
            descriptionLabel.text = videoItem?.snippet.description
        }
    }

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //backgroundColor = .purple
        
        channelImageView.layer.cornerRadius = 40 / 2
    }

}

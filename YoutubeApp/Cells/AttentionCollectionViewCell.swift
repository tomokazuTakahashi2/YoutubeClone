//
//  AttentionCollectionViewCell.swift
//  YoutubeApp
//
//  Created by Raphael on 2020/10/12.
//  Copyright © 2020 Raphael. All rights reserved.
//

import UIKit
import Nuke

class AttentionCollectionViewCell: UICollectionViewCell {
    
    var videoItem: Item? {
        didSet {
            //動画サムネ画像の表示
            if let url = URL(string: videoItem?.snippet.thumbnails.medium.url ?? ""){
                //Nukeでカクツキをなくす
                Nuke.loadImage(with: url, into: thumbnailImageView)
            }
            //タイトルの表示
            videoTitleLabel.text = videoItem?.snippet.title
            //チャンネルタイトルの表示
            channekTitleLabel.text = videoItem?.channel?.items[0].snippet.title
            //本文の表示
            descriptionLabel.text = videoItem?.snippet.description
            
        }
    }

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var channekTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}

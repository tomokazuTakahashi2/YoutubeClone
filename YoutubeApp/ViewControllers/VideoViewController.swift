//
//  VideoViewController.swift
//  YoutubeApp
//
//  Created by Raphael on 2020/10/12.
//  Copyright © 2020 Raphael. All rights reserved.
//

import UIKit
import Nuke

class VideoViewController: UIViewController {

    var selectedItem: Item?
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var baseBackGroundView: UIView!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.baseBackGroundView.alpha = 1
        }
    }
    

    private func setupViews() {
        //チャンネルイメージビューを丸くする
        channelImageView.layer.cornerRadius = 45 / 2

        //動画サムネ画像の表示
        if let url = URL(string: selectedItem?.snippet.thumbnails.medium.url ?? ""){
            //Nukeでカクツキをなくす
            Nuke.loadImage(with: url, into: videoImageView)
        }
        //チャンネルアイコンの表示
        if let channelUrl = URL(string: selectedItem?.channel?.items[0].snippet.thumbnails.medium.url ?? ""){
            //Nukeでカクツキをなくす
            Nuke.loadImage(with: channelUrl, into: channelImageView)
        }
        //タイトルの表示
        videoTitleLabel.text = selectedItem?.snippet.title
        //チャンネルタイトルの表示
        channelTitleLabel.text = selectedItem?.channel?.items[0].snippet.title
        
        //パンジェスチャー
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panVideoImageView))
        videoImageView.addGestureRecognizer(panGesture)
    }
    //パンジェスチャー
    @objc private func panVideoImageView(gesture: UIPanGestureRecognizer){
        
        guard let imageView = gesture.view else {return}
        let move = gesture.translation(in: imageView)
        //動いている時
        if gesture.state == .changed {
            //y軸にスワイプした動きに応じて動かす
            imageView.transform = CGAffineTransform(translationX: 0, y: move.y)
        //動いていない時
        }else if gesture.state == .ended{
            
            //手を離すと元に戻る
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8,options: [], animations: {
                
                imageView.transform = .identity
                //アニメーションを反映する
                self.view.layoutIfNeeded()
            })

        }
    }

}

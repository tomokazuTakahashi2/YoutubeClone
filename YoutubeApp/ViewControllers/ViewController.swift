//
//  ViewController.swift
//  YoutubeApp
//
//  Created by Raphael on 2020/10/07.
//  Copyright © 2020 Raphael. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController{
    
    private let cellId = "cellId"
    private var videoItems = [Item]()
    
    private var prevCotentOffset: CGPoint = .init(x: 0, y: 0)
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var videoListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //コレクションビューの背景色
        //videoListCollectionView.backgroundColor = .black
        
        //コレクションビューの２セット
        videoListCollectionView.delegate = self
        videoListCollectionView.dataSource = self
        
        //カスタムセル
        videoListCollectionView.register(UINib(nibName: "VideoListCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        //プロフィール画像を丸くする
        profileImageView.layer.cornerRadius = 20
        
        //APIを読み込む
        fetchYoutubeSerachInfo()
    }
    //検索用APIの取得
    private func fetchYoutubeSerachInfo(){
        
        let params = ["q": "hikakin"]
        
        API.shared.request(path: .search, params: params, type: Video.self){(video) in
            
            self.videoItems = video.items
            //チャンネルIDの取得
            let id = self.videoItems[0].snippet.channelId
            self.fetchYoutubeChannelInfo(id: id)
    
        }
    }
    //チャンネル情報APIの取得
    private func fetchYoutubeChannelInfo(id: String){
        
        let params = ["id": id]
        
            API.shared.request(path: .channels, params: params, type: Channel.self){(channel) in
            
            //チャンネル情報の取得
            self.videoItems.forEach{ (item) in
                item.channel = channel
            }
            //コレクションビューを再読み込み
            self.videoListCollectionView.reloadData()
        }
        
    }
//MARK:-スクロールビューのヘッダーアニメーション
    //スクロール時にヘッダーを移動させる
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        //0.5秒前の位置と今の位置を比較し、上にスクロールしているのか下にスクロールしているのかを判断する
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.prevCotentOffset = scrollView.contentOffset
        }
        //ヘッダーの透明度（ヘッダーの高さに比例して薄くする）
        let alphaRatio = 1 / headerHeightConstraint.constant

        //上スクロールだったら、
        if self.prevCotentOffset.y < scrollView.contentOffset.y {
            //ヘッダーを縮める
            if headerTopConstraint.constant <= -headerHeightConstraint.constant { return }
            headerTopConstraint.constant -= 1
            //高さに応じて薄くなっていく
            headerView.alpha -= alphaRatio
        //下スクロールだったら、
        }else if self.prevCotentOffset.y > scrollView.contentOffset.y {
            //ヘッダーを元に戻す
            if headerTopConstraint.constant >= 0 { return }
            headerTopConstraint.constant += 1
            //高さに応じて濃くなっていく
            headerView.alpha += alphaRatio
        }
    }
    // ドラッグの終わり
    // decelerate が true ならまだ減速しながらスクロール中、false ならスクロールは止まっている。
    // ドラッグをピタッと止めて、慣性なしでドラッグを終えた場合に decelerate = false になる。
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        headerViewEndanimation()
    }
    // 減速終了時 -> ★呼ばれない場合あり
    // scrollViewDidEndDragging で decelerate が true であれば呼ばれ、false であれば呼ばれない。
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        headerViewEndanimation()
    }
    
    private func headerViewEndanimation() {
        //ヘッダーが半分より上に行っていたら、
        if headerTopConstraint.constant < -headerHeightConstraint.constant / 2 {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: [], animations: {
                //上に行ききり、
                self.headerTopConstraint.constant = -self.headerHeightConstraint.constant
                //透明にし、
                self.headerView.alpha = 0
                //アニメーションの動きをつける
                self.view.layoutIfNeeded()
            })
        //ヘッダーが半分より下に行っていたら、
        }else{
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: [], animations: {
                //全表示にし、
                self.headerTopConstraint.constant = 0
                //透明でなく、
                self.headerView.alpha = 1
                //アニメーションの動きをつける
                self.view.layoutIfNeeded()
            })
        }
    }
}
//MARK:-コレクションビュー
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //配置
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width
        //幅はフレームの幅、高さはフレームの幅
        return.init(width: width, height: width)
    }
        
    //セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoItems.count
    }
    //セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //カスタムセル
        let cell = videoListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)as! VideoListCell
        
        cell.videoItem = videoItems[indexPath.row]
        
        return cell
    }
}

